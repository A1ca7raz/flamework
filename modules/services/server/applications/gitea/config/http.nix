{ config, ... }:
let
  cfg = config.lib.gitea;
in {
  utils.gitea.server = {
    PROTOCOL = "http";
    DOMAIN = cfg.domain;
    ROOT_URL = "https://${cfg.domain}/";
    HTTP_ADDR = "127.0.0.1";
    HTTP_PORT = 60005;

    ENABLE_GZIP = true;
  };
}