{ lib, pkgs, ... }:
with lib; let
  enable = true;
  configFile = "/home/nomad/.config/sing-box/config.json";
  webUi = {
    package = pkgs.clash-webui-yacd-meta;
  };
in {
  environment.persistence."/nix/persist".users.nomad.directories = [ ".config/sing-box" ];

  systemd.services.sing-box = optionalAttrs enable (
    with pkgs; let
    startScript = pkgs.writeShellScriptBin "sing-box-start" ''
      CONF_DIR=${"\$\{STATE_DIRECTORY:-/var/lib/sing-box}"}
      CONF=$1
      echo "Config Path: $CONF"
      mkdir -p $CONF_DIR

      ${sing-box}/bin/sing-box run -D $CONF_DIR -c $CONF
    '';

    caps = [
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
    port = 80;
    document-root = "${webUi.package}/share/clash/ui";
    extraConfig = ''server.bind = "127.0.0.88"'';
  };

  networking.hosts = {
    "127.0.0.88" = [ "yacd.local" ];    # Yacd Dashboard
    "127.0.0.64" = [ "singbox.local" ]; # Sing-box
  };
}
