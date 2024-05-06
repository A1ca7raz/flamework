{ config, lib, ... }:
let
  constant = config.lib.services.gitea;
in {
  # Caddy
  services.caddy.virtualHosts.gitea = {
    hostName = lib.elemAt constant.domains 0;
    listenAddresses = lib.removeCIDRSuffixes constant.ipAddrs;
    serverAliases = [];

    extraConfig = ''
      reverse_proxy http://127.0.0.1:60005 {
        header_up X-Real-IP {remote}
        header_up Host {host}
      }
    '';
  };

  # netns
  utils.netns.veth.gitea = {
    bridge = "0";
    netns = "proxy";
    ipAddrs = constant.ipAddrs;
    addDefaultRoute = false;
  };

  systemd.services.caddy = {
    after = [ "netns-veth-gitea.service" ];
    bindsTo = [ "netns-veth-gitea.service" ];
  };

  systemd.services.gitea = {
    bindsTo = [ "netns-veth-gitea.service" ];
    requires = [
      "authentik.service"
      "minio.service"
      "redis-gitea.service"
    ];
    after = [
      "netns-veth-gitea.service"
      "authentik.service"
      "minio.service"
      "redis-gitea.service"
      "postgresql.service"
    ];
    serviceConfig.NetworkNamespacePath = "/run/netns/proxy";
  };
}