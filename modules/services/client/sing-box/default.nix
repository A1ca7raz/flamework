{ config, lib, pkgs, ... }:
with lib; let
  enable = true;
  configFile = "$STATE_DIRECTORY/config.json";
  subscriptionURI = config.sops.secrets.sing-box.path;

  uiPackage = pkgs.clash-webui-yacd-meta;
in {
  utils.secrets.sing-box.enable = true;
  sops.secrets.sing-box.mode = "0600";

  systemd.services.sing-box = optionalAttrs enable (
    with pkgs; let
      startScript = pkgs.writeShellScriptBin "sing-box-start" ''
        SUB_URI=$1
        CONF_DIR=${"\$\{STATE_DIRECTORY:-/var/lib/sing-box}"}
        CONF=${configFile}
        mkdir -p $CONF_DIR

        curl -L `cat $SUB_URI` -o $CONF
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
        LoadCredential = "subscription_uri:${subscriptionURI}";
        ExecStart = "${getExe startScript} %d/subscription_uri";
        StateDirectory = "sing-box";
        CapabilityBoundingSet = caps;
        AmbientCapabilities = caps;
        NoNewPrivileges = "yes";
        User = "sing-box";
        Group = "sing-box";
        DynamicUser = "yes";

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
