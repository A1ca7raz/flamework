{ config, path, pkgs, ... }:
{
  sops.secrets.mypwd.neededForUsers = true;

  users.users.nomad = {
    isNormalUser = true;

    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];

    passwordFile = config.sops.secrets.mypwd.path;
    openssh.authorizedKeys.keys = import /${path}/config/sshkeys.nix;
  };
}