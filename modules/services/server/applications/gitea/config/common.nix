{ pkgs, lib, config, tools, ... }:
let
  cfg = config.lib.gitea;
  constant = config.lib.services.gitea;
in {
  lib.gitea = {
    package = pkgs.gitea;
    user = "git";
    group = "git";
    stateDir = "/var/lib/gitea";
    customDir = "${cfg.stateDir}/custom";
    backupDir = "${cfg.stateDir}/dump";
    lfsDir = "${cfg.stateDir}/data/lfs";
    repositoryRoot = "${cfg.stateDir}/repositories";

    ip = tools.removeCIDRSuffix (lib.elemAt constant.ipAddrs 0);
    domain = lib.elemAt constant.domains 0;
  };
}