{ config, ... }:
let
  cfg = config.lib.gitea;
in {
  utils.gitea = {
    repository = {
      ROOT = cfg.repositoryRoot;
      DEFAULT_PRIVATE = "public";
      # Enable push to create
      DEFAULT_PUSH_CREATE_PRIVATE = true;
      ENABLE_PUSH_CREATE_USER = true;
      ENABLE_PUSH_CREATE_ORG = true;
    };

    # "git.timeout" = {
    #   DEFAULT = 3600;
    #   MIGRATE = 3600;
    #   MIRROR = 3600;
    #   CLONE = 3600;
    #   PULL = 3600;
    #   GC = 3600;
    # };
  };
}