{ config, pkgs, path, ... }:
{
  sops.secrets.rootpwd.neededForUsers = true;

  users.users.root = {
    shell = pkgs.fish;

    passwordFile = config.sops.secrets.rootpwd.path;
    openssh.authorizedKeys.keys = import /${path}/config/sshkeys.nix;
  };
}