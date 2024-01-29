{ config, ... }:
let
  cfg = config.utils.gitea;
in {
  imports = [
    ./sops.nix
    ./service.nix
    ./proxy.nix
    ./config
  ];

  # PostgreSQL
  services.postgresql = {
    ensureDatabases =  [ cfg.database.NAME ];
    ensureUsers = [ { name = cfg.database.USER; ensureDBOwnership = true; } ];
  };

  # Redis
  services.redis.servers.gitea = {
    enable = true;
    databases = 1;
    port = 63792;
  };
  systemd.services.redis-gitea = {
    after = [ "netns-veth-gitea.service" ];
    bindsTo = [ "netns-veth-gitea.service" ];
    serviceConfig.NetworkNamespacePath = "/run/netns/proxy";
  };
}