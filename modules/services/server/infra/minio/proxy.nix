{ config, tools, lib, ... }:
let
  constant = config.lib.services.minio;
  constant_ui = config.lib.services.minio-ui;
in {
  # Caddy
  services.caddy.virtualHosts.minio = {
    hostName = lib.elemAt constant.domains 0;
    listenAddresses = tools.removeCIDRSuffixes constant.ipAddrs;
    serverAliases = [];

    extraConfig = ''
      reverse_proxy http://127.0.0.1:60003 {
        header_up X-Forwarded-Proto {scheme}
        header_up X-Forwarded-Host {host}
        header_up X-Real-IP {remote}
        header_up Host {host}
      }
    '';
  };

  services.caddy.virtualHosts.minio-ui = {
    hostName = lib.elemAt constant_ui.domains 0;
    listenAddresses = tools.removeCIDRSuffixes constant_ui.ipAddrs;
    serverAliases = [];

    extraConfig = ''
      reverse_proxy http://127.0.0.1:60004 {
        header_up X-Forwarded-Proto {scheme}
        header_up X-Forwarded-Host {host}
        header_up X-Real-IP {remote}
        header_up Host {host}
      }
    '';
  };

  # netns
  utils.netns.veth.minio = {
    bridge = "0";
    netns = "proxy";
    ipAddrs = constant.ipAddrs ++ constant_ui.ipAddrs;
    addDefaultRoute = false;
  };

  systemd.services.caddy = {
    after = [ "netns-veth-minio.service" ];
    bindsTo = [ "netns-veth-minio.service" ];
  };
}