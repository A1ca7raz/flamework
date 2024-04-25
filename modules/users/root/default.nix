{ pkgs, lib, config, path, ... }:
{
  utils.secrets.rootpwd.enable = true;
  sops.secrets.rootpwd.neededForUsers = true;

  users.users.root = {
    shell = pkgs.fish;

    hashedPasswordFile = config.sops.secrets.rootpwd.path;
    openssh.authorizedKeys.keys = import /${path}/config/sshkeys.nix;
  };

  programs.fish.enable = lib.mkDefault true;
}