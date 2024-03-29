{ config, lib, ... }:
let
  inherit (config.sops) placeholder;
in {
  utils.gitea.storage = {
    STORAGE_TYPE = "minio";
    MINIO_ENDPOINT = lib.elemAt config.lib.services.minio.domains 0;
    MINIO_ACCESS_KEY_ID = placeholder."gitea/minio_assets_access_key_id";
    MINIO_SECRET_ACCESS_KEY = placeholder."gitea/minio_assets_access_key_secret";
    MINIO_BUCKET = "bucket-gitea-assets";
    MINIO_USE_SSL = true;
  };
}