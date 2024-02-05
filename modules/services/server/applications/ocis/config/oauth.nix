{ config, ... }:
{
  lib.ocis_env = {
    OCIS_OIDC_ISSUER = "https://id.insyder/application/o/ocis/";
    WEB_OIDC_CLIENT_ID = config.sops.placeholder."ocis/oauth_id";
    PROXY_OIDC_REWRITE_WELLKNOWN = true;
    PROXY_AUTOPROVISION_ACCOUNTS = true;
    PROXY_OIDC_ACCESS_TOKEN_VERIFY_METHOD = "none";
  };
}