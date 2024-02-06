{ config, lib, pkgs, ... }:
with lib; let
  enable = true;
  configFile = "/var/lib/sing-box/config.json";
  updateTimeoutMin = "720";
  subscriptionEnv = config.sops.secrets.sing-box.path;

  uiPackage = pkgs.clash-webui-yacd-meta;
in {
  utils.secrets.sing-box.enable = true;
  sops.secrets.sing-box.mode = "0600";

  systemd.services.sing-box = optionalAttrs enable (
    let
      caps = [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" ];
    in {
      description = "Sing-box networking service";
      wantedBy = [ "multi-user.target" ];
      requires = [ "network-online.target" ];
      after = [ "network-online.target" ];
      path = with pkgs; [ curl sing-box ];

      environment = {
        SB_WORK_DIR = "/var/lib/sing-box";
        SB_CONF_FILE = configFile;
      };

      serviceConfig = {
        Type = "simple";
        User = "sing-box";
        Group = "sing-box";
        StateDirectory = "sing-box";
        EnvironmentFile = [ subscriptionEnv ];
        ExecStart = "${pkgs.sing-box}/bin/sing-box run -D $SB_WORK_DIR -c $SB_CONF_FILE";

        # Sing-box Auto Update
        Restart = "always";
        RuntimeMaxSec = "${updateTimeoutMin}min";

        # OOM Killer
        OOMPolicy = "kill";
        MemoryMax = "200M";

        DynamicUser = "yes";
        # Capabilities
        CapabilityBoundingSet = caps;
        AmbientCapabilities = caps;
        # Proc filesystem
        ProcSubset = "pid";
        ProtectProc = "invisible";
        # Security
        NoNewPrivileges = true;
        # Sandboxing
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        # PrivateDevices = true;        # NOT WORK on Tun Mode
        PrivateMounts = true;
        PrivateTmp = true;
        # PrivateUsers = true;          # NOT WORK on Tun Mode
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = "strict";
        RemoveIPC = true;
        RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_NETLINK" ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        # System Call Filtering
        SystemCallArchitectures = "native";
        SystemCallFilter = [ "~@cpu-emulation @debug @keyring @mount @obsolete @privileged @setuid" "setrlimit" ];
      };

      preStop = ''
        curl --connect-timeout 5 --retry 3 --retry-delay 1 \
          -L $SB_SUBSCRIPTION_URI \
          -o $SB_CONF_FILE
      '';

      preStart = ''
        [[ -d $SB_WORK_DIR ]] || mkdir -p $SB_WORK_DIR

        if [[ -f $SB_CONF_FILE ]] && test `find $SB_CONF_FILE -mmin -2`; then
          :
        elif [[ -f $SB_CONF_FILE ]] && test `find $SB_CONF_FILE -mmin -${updateTimeoutMin}`; then
          curl --connect-timeout 5 \
            -L $SB_SUBSCRIPTION_URI \
            -o $SB_CONF_FILE
        else
          curl --connect-timeout 5 --retry 3 --retry-delay 1 \
            -L $SB_SUBSCRIPTION_URI \
            -o $SB_CONF_FILE
        fi

        [[ -f $SB_CONF_FILE ]] && chmod 0600 $SB_CONF_FILE || exit 1      
      '';
    }
  );

  services.lighttpd = {
    inherit enable;
    port = 80;
    document-root = "${uiPackage}/share/clash/ui";
    extraConfig = ''server.bind = "127.0.0.88"'';
  };

  networking.hosts = {
    "127.0.0.88" = [ "yacd.local" ];    # Yacd Dashboard
    "127.0.0.64" = [ "singbox.local" ]; # Sing-box
  };
}
