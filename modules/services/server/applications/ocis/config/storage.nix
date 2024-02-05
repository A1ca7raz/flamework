{ config, lib, ... }:
let
  ph = config.sops.placeholder;
in {
  lib.ocis_env = {
    STORAGE_USERS_DRIVER = "s3ng";
    STORAGE_USERS_S3NG_ENDPOINT = "https://${lib.elemAt config.lib.services.minio.domains 0}";
    STORAGE_USERS_S3NG_REGION = "default";
    STORAGE_USERS_S3NG_ACCESS_KEY = ph."ocis/minio_access_key_id";
    STORAGE_USERS_S3NG_SECRET_KEY = ph."ocis/minio_secret_access_key";
    STORAGE_USERS_S3NG_BUCKET = "bucket-ocis";

    STORAGE_SYSTEM_DRIVER = "ocis";
  };
}