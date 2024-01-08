{ pkgs, path, ... }:
{
  utils.secrets.rootpwd.enable = true;
  sops.secrets.rootpwd.neededForUsers = true;

  users.users.root = {
    shell = pkgs.fish;

    # passwordFile = config.sops.secrets.rootpwd.path;
    password = "asd";
    openssh.authorizedKeys.keys = import /${path}/config/sshkeys.nix;
  };
}