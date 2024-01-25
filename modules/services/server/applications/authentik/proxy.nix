{ config, tools, lib, ... }:
let
  constant = config.lib.services.authentik;
in {
  # Caddy
  services.caddy.virtualHosts.authentik = {
    hostName = lib.elemAt constant.domains 0;
    listenAddresses = tools.removeCIDRSuffixes constant.ipAddrs;
    serverAliases = [];

    extraConfig = ''
      reverse_proxy http://127.0.0.1:60001 {
        header_up X-Forwarded-Proto {scheme}
        header_up X-Forwarded-Host {host}
        header_up X-Real-IP {remote}
        header_up Host {host}
      }
    '';
  };

  # netns
  utils.netns.veth.authentik = {
    bridge = "0";
    netns = "proxy";
    inherit (constant) ipAddrs;
    addDefaultRoute = false;
  };

  systemd.services.caddy = {
    after = [ "netns-veth-authentik.service" ];
    bindsTo = [ "netns-veth-authentik.service" ];
  };
}