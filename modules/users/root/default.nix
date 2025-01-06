{ pkgs, lib, config, const, ... }:
{
  utils.secrets.rootpwd.path = ./rootpwd.enc.json;
  sops.secrets.rootpwd.neededForUsers = true;

  users.users.root = {
    shell = pkgs.fish;

    openssh.authorizedKeys.keys = const.sshkeys;
  } // (with lib.utils; (
    if isDebug
    then { password = "asd"; }
    else { hashedPasswordFile = config.sops.secrets.rootpwd.path; }
  ));

  programs.fish.enable = lib.mkDefault true;
}
