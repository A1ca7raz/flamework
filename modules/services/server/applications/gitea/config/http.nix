{ config, ... }:
let
  cfg = config.lib.gitea;
in {
  utils.gitea.server = {
    PROTOCOL = "https";
    DOMAIN = cfg.domain;
    ROOT_URL = "https://${cfg.domain}/";
    HTTP_ADDR = cfg.ip;
    HTTP_PORT = 443;
    # HTTP Redirect
    REDIRECT_OTHER_PORT = true;
    PORT_TO_REDIRECT = 80;
    # HTTPS ACME
    ENABLE_ACME = true;
    ACME_ACCEPTTOS = true;
    ACME_URL = "https://pki.insyder/acme/x1/directory";
    ACME_DIRECTORY = "https";

    ENABLE_GZIP = true;
  };
}