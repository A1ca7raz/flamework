{ config, lib, ... }:
with lib; let
  cfg = config.utils.gitea;
  cfg_ = config.lib.gitea;
  enabled = {
    sopsFile = ./secrets.yml;
  };
in {
  imports = importsFiles ./config;
  options.utils.gitea = mkOption {
    default = {};
    type = with types; attrsOf attrs;
  };

  config = {
    # Secrets
    sops.secrets = {
      "gitea/internal_token" = enabled;
      "gitea/lfs_jwt_secret" = enabled;
      "gitea/minio_assets_access_key_id" = enabled;
      "gitea/minio_assets_access_key_secret" = enabled;
      "gitea/secret_key" = enabled;
      "gitea/oauth2_jwt_secret" = enabled;
    };

    # Final configuration
    sops.templates.gitea_config = {
      content = generators.toINI {} cfg;
      path = "${cfg_.customDir}/conf/app.ini";
      owner = cfg_.user;
      group = cfg_.group;
      mode = "0750";
    };
  };
}