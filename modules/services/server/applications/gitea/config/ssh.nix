{ config, ... }:
{
  utils.gitea.server = {
    SSH_DOMAIN = config.lib.gitea.domain;
    SSH_PORT = 22;
  };
}