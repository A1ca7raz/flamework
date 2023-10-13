{ lib, pkgs, ... }:
with lib; let
  enable = true;
  configFile = "/home/nomad/.config/sing-box/config.json";
  webUi = {
    port = 6789;
    package = pkgs.clash-webui-yacd;
  };
in {
  systemd.services.sing-box = optionalAttrs enable (
    with pkgs; let
    startScript = pkgs.writeShellScriptBin "sing-box-start" ''
      CONF_DIR=${"\$\{STATE_DIRECTORY:-/var/lib/sing-box}"}
      CONF=$1
      echo "Config Path: $CONF"
      mkdir -p $CONF_DIR

      ${getExe sing-box} -D $CONF_DIR -c $CONF
    '';

    caps = [
      "CAP_NET_RAW"
      "CAP_NET_ADMIN"
      "CAP_NET_BIND_SERVICE"
    ];
    in {
      description = "Sing-box networking service";
      path = [ coreutils ];
      # Don't start if the config file doesn't exist.
      unitConfig = {
        # NOTE: configPath is for the original config which is linked to the following path.
        ConditionPathExists = configFile;
      };

      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];

      serviceConfig = {
        Type = "simple";
        LoadCredential = "config:${configFile}";
        ExecStart = "${getExe startScript} %d/config";
        Restart = "on-failure";
        StateDirectory = "sing-box";
        CapabilityBoundingSet = caps;
        AmbientCapabilities = caps;
        NoNewPrivileges = "yes";
        DynamicUser = "yes";
      };
    }
  );

  services.lighttpd = {
    inherit enable;
    port = webUi.port;
    document-root = "${webUi.package}/share/clash/ui";
  };
}
