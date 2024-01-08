{ config, lib, pkgs, ... }:
with lib; let
  enable = true;
  configFile = "$STATE_DIRECTORY/config.json";
  subscriptionURI = config.sops.secrets.sing-box.path;

  uiPackage = pkgs.clash-webui-yacd-meta;
in {
  utils.secrets.sing-box.enable = true;
  sops.secrets.sing-box = {
    mode = "0700";
    owner = "sing-box";
    group = "sing-box";
  };

  users.users."sing-box" = {
    isSystemUser = true;
    group = "sing-box";
    description = "Sing-box daemon user";
    home = "/var/lib/sing-box";
  };

  users.groups."sing-box" = {};

  systemd.services.sing-box = optionalAttrs enable (
    with pkgs; let
      startScript = pkgs.writeShellScriptBin "sing-box-start" ''
        CONF_DIR=${"\$\{STATE_DIRECTORY:-/var/lib/sing-box}"}
        CONF=${configFile}
        mkdir -p $CONF_DIR

        curl -L `cat ${subscriptionURI}` -o $CONF
        chmod 0700 $CONF
        ${sing-box}/bin/sing-box run -D $CONF_DIR -c $CONF
      '';

      caps = [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" ];
    in {
      description = "Sing-box networking service";
      path = [ coreutils curl ];

      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${getExe startScript}";
        StateDirectory = "sing-box";
        CapabilityBoundingSet = caps;
        AmbientCapabilities = caps;
        NoNewPrivileges = "yes";
        User = "sing-box";
        Group = "sing-box";

        # Sing-box auto update
        Restart = "always";
        RuntimeMaxSec = "12h";
      };
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
