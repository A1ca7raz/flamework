{ config, lib, pkgs, ... }:
with lib; let
  pkg = pkgs.mihomo;
  subscriptionEnv = config.sops.secrets.mihomo.path;
in {
  # FIXME: use tproxy
  # imports = [ ./tproxy.nix ];

  utils.secrets.mihomo.path = ./env.enc.json;
  sops.secrets.mihomo.mode = "0600";

  systemd.services.mihomo =
  let
    caps = [
      "CAP_NET_ADMIN"
      "CAP_NET_BIND_SERVICE"
    ];
  in {
    description = "Mihomo networking service";
    wantedBy = [ "multi-user.target" ];
    requires = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = with pkgs; [
      curl
      pkg
    ];

    preStart = ''
      if [[ -f $STATE_DIRECTORY/config.yaml ]]; then
        [[ `find $STATE_DIRECTORY/config.yaml -mmin -3` ]] && \
          echo "Detected recent-updated configuration. Skip fetching latest configuration." && \
          exit 0

        echo "Backup last configuration."
        mv $STATE_DIRECTORY/config.yaml $STATE_DIRECTORY/config.bak.yaml
      fi

      echo "Fetching latest configuration..."
      curl --connect-timeout 5 --retry 3 --retry-delay 1 \
        -L $MIHOMO_SUBSCRIPTION_URI \
        -o $STATE_DIRECTORY/config.yaml

      # Restore backup if current config cannot pass the check
      if ! [[ -f $STATE_DIRECTORY/config.yaml && `mihomo -t -d $STATE_DIRECTORY -f $STATE_DIRECTORY/config.yaml` ]]; then
        echo "Fetching failed."
        rm -f $STATE_DIRECTORY/config.yaml

        if [[ -f $STATE_DIRECTORY/config.bak.yaml && `mihomo -t -d $STATE_DIRECTORY -f $STATE_DIRECTORY/config.bak.yaml` ]]; then
          echo "Backup is valid. Restore it."
          mv $STATE_DIRECTORY/config.bak.yaml $STATE_DIRECTORY/config.yaml
        else
          rm -f $STATE_DIRECTORY/config.bak.yaml
          echo "No valid backup. Failed to start the service."
          exit 1
        fi
      fi

      chmod 0600 $STATE_DIRECTORY/config*
    '';

    preStop = ''
      if ! [[ -f $STATE_DIRECTORY/config.yaml && `find $STATE_DIRECTORY/config.yaml -mmin -2` ]]; then
        echo "Updating configuration..."
        curl --connect-timeout 5 --retry 3 --retry-delay 1 \
          -L $MIHOMO_SUBSCRIPTION_URI \
          -o $STATE_DIRECTORY/config.new.yaml

        if [[ -f $STATE_DIRECTORY/config.new.yaml && `mihomo -t -d $STATE_DIRECTORY -f $STATE_DIRECTORY/config.new.yaml` ]]; then
          echo "Update complete. Backup the old configuration."
          mv $STATE_DIRECTORY/config.yaml $STATE_DIRECTORY/config.bak.yaml
          mv $STATE_DIRECTORY/config.new.yaml $STATE_DIRECTORY/config.yaml
        else
          echo "Update failed. Rollback the configuration."
          rm -f $STATE_DIRECTORY/config.new.yaml
        fi
      fi

      chmod 0600 $STATE_DIRECTORY/config*
    '';

    serviceConfig = {
      Type = "simple";
      User = "mihomo";
      Group = "mihomo";
      EnvironmentFile = [ subscriptionEnv ];

      ExecStart = lib.concatStringsSep " " [
        (lib.getExe pkg)
        "-d \${STATE_DIRECTORY}"
        "-f \${STATE_DIRECTORY}/config.yaml"
      ];

      Restart = "on-failure";
      StateDirectory = "mihomo";

      # Prevent error - too many open files
      LimitNPROC = 500;
      LimitNOFILE = 1000000;

      # OOM Killer
      OOMPolicy = "kill";
      MemoryMax = "300M";

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
      SystemCallFilter = "@system-service bpf";
    };
  };

  services.lighttpd = {
    enable = true;
    port = 80;
    document-root = "${pkgs.metacubexd}";
    extraConfig = ''server.bind = "127.0.0.88"'';
  };

  networking.hosts = {
    "127.0.0.64" = [ "mihomo.local" ];  # Mihomo
    "127.0.0.88" = [ "cube.local" ];    # Dashboard
  };
}
