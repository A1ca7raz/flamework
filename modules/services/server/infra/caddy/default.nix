{ config, ... }:
{
  services.caddy = {
    enable = true;
    acmeCA = "https://pki.insyder/acme/x1/directory";
  };

  # Reverse proxy netns
  utils.netns.veth.caddy = {
    bridge = "0";
    netns = "proxy";
    inherit (config.lib.services.caddy) ipAddrs;
  };

  systemd.services.caddy = {
    after = [ "netns-veth-caddy.service" ];
    bindsTo = [ "netns-veth-caddy.service" ];
    serviceConfig.NetworkNamespacePath = "/run/netns/proxy";
  };
}