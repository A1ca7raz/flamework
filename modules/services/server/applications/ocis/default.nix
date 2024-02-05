{ ... }:
{
  imports = [
    ./service.nix
    ./proxy.nix
    ./config.nix
  ];

  users.users.ocis = {
    description = "oCIS Service";
    useDefaultShell = true;
    group = "ocis";
    isSystemUser = true;
  };
  users.groups.ocis = {};

  # Redis
  services.redis.servers.ocis = {
    enable = true;
    databases = 1;
    # TODO: use socket
    port = 63793;
  };
  systemd.services.redis-ocis = {
    after = [ "netns-veth-ocis.service" ];
    bindsTo = [ "netns-veth-ocis.service" ];
    serviceConfig.NetworkNamespacePath = "/run/netns/proxy";
  };
}