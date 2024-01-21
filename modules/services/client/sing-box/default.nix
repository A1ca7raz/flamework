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
      after = [ "network-online.target" ];
      path = with pkgs; [ coreutils curl sing-box ];

      serviceConfig = {
        Type = "simple";
        StateDirectory = "sing-box";
        CapabilityBoundingSet = caps;
        AmbientCapabilities = caps;
        NoNewPrivileges = "yes";
        User = "sing-box";
        Group = "sing-box";
        DynamicUser = "yes";

        EnvironmentFile = [ subscriptionEnv ];

        # Sing-box auto update
        Restart = "always";
        RuntimeMaxSec = "${updateTimeoutMin}min";

        OOMPolicy = "kill";
        MemoryMax = "200M";
      };

      environment = {
        SB_WORK_DIR = "/var/lib/sing-box";
        SB_CONF_FILE = configFile;
      };

      preStop = ''
        curl --connect-timeout 5 --retry 3 --retry-delay 1 \
          -L $SB_SUBSCRIPTION_URI \
          -o $SB_CONF_FILE
      '';

      script = ''
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

        [[ -f $SB_CONF_FILE ]] && chmod 0700 $SB_CONF_FILE || exit 1

        sing-box run -D $SB_WORK_DIR -c $SB_CONF_FILE
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
