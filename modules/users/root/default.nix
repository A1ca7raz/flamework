{ pkgs, lib, config, path, ... }:
{
  utils.secrets.rootpwd.enable = true;
  sops.secrets.rootpwd.neededForUsers = true;

  users.users.root = {
    shell = pkgs.fish;

    openssh.authorizedKeys.keys = import /${path}/config/sshkeys.nix;
  } // (with lib.utils; (
    if isDebug
    then { password = "asd"; }
    else { hashedPasswordFile = config.sops.secrets.rootpwd.path; }
  ));

  programs.fish.enable = lib.mkDefault true;
}