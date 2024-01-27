{ config, tools, ... }:
let
  cfg = config.utils.gitea;
  constant = config.lib.services.gitea;
in {
  imports = [
    ./sops.nix
    ./service.nix
    ./config
  ];

  # PostgreSQL
  services.postgresql = {
    ensureDatabases =  [ cfg.database.NAME ];
    ensureUsers = [ { name = cfg.database.USER; ensureDBOwnership = true; } ];
  };

  # netns
  utils.netns.veth.gitea = {
    bridge = "0";
    netns = "gitea";
    inherit (constant) ipAddrs;
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
      "caddy.service"
      "minio.service"
      "redis-gitea.service"
    ];
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
    serviceConfig.NetworkNamespacePath = "/run/netns/gitea";
  };
}