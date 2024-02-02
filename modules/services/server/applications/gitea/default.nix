{ config, ... }:
let
  cfg = config.utils.gitea;
in {
  imports = [
    ./sops.nix
    ./service.nix
    ./proxy.nix
    ./config
    # TODO: 给repository挂载rclone s3/seaweedfs
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