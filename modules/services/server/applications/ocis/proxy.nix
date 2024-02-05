{ config, tools, lib, ... }:
let
  constant = config.lib.services.ocis;
in {
  # Caddy
  services.caddy.virtualHosts.ocis = {
    hostName = lib.elemAt constant.domains 0;
    listenAddresses = tools.removeCIDRSuffixes constant.ipAddrs;
    serverAliases = [];

    extraConfig = ''
      reverse_proxy http://127.0.0.1:60002 {
        header_up X-Real-IP {remote}
        header_up Host {host}
      }
    '';
  };

  # netns
  utils.netns.veth.ocis = {
    bridge = "0";
    netns = "proxy";
    ipAddrs = constant.ipAddrs;
    addDefaultRoute = false;
  };
  systemd.services.caddy = {
    after = [ "netns-veth-ocis.service" ];
    bindsTo = [ "netns-veth-ocis.service" ];
  };
  systemd.services.ocis = {
    bindsTo = [ "netns-veth-ocis.service" ];
    requires = [
      "authentik.service"
      "minio.service"
      "redis-ocis.service"
      "postgresql.service"
    ];
    after = [
      "netns-veth-ocis.service"
      "authentik.service"
      "minio.service"
      "redis-ocis.service"
      "postgresql.service"
    ];
    serviceConfig.NetworkNamespacePath = "/run/netns/proxy";
  };
}