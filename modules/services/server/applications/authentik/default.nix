{ ... }:
{
  imports = [
    ./services.nix
    ./proxy.nix
  ];

  # Redis
  services.redis.servers.authentik = {
    enable = true;
    databases = 1;
    port = 63791;
  };
  systemd.services.redis-authentik = {
    after = [ "netns-veth-authentik.service" ];
    bindsTo = [ "netns-veth-authentik.service" ];
    serviceConfig.NetworkNamespacePath = "/run/netns/proxy";
  };

  # PostgreSQL
  services.postgresql = {
    ensureDatabases =  [ "authentik" ];
    ensureUsers = [ { name = "authentik"; ensureDBOwnership = true; } ];
  };

  # Secret
  utils.secrets.authentik_env.enable = true;
}