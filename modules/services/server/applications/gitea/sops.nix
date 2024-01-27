{ config, lib, ... }:
let
  cfg = config.utils.gitea;
  cfg_ = config.lib.gitea;
  enabled = {
    enable = true;
    owner = cfg_.user;
    group = cfg_.group;
    mode = "0750";
  };
in {
  # Secrets
  utils.secrets = {
    gitea_internal_token = enabled;
    gitea_lfs_jwt_secret = enabled;
    gitea_minio_access_key_id = enabled;
    gitea_minio_secret_access_key = enabled;
    gitea_secret_key = enabled;
  };

  # Final configuration
  sops.templates.gitea_config = {
    content = lib.generators.toINI {} cfg;
    path = "/var/lib/gitea/conf/app.ini";
    owner = cfg_.user;
    group = cfg_.group;
    mode = "0750";
  };
}