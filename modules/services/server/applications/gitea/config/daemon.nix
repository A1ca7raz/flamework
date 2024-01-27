{ config, ... }:
let
  cfg = config.lib.gitea;
in {
  utils.gitea.DEFAULT = {
    RUN_USER = cfg.user;
    RUN_MODE = "prod";
    WORK_PATH = cfg.stateDir;
  };
}