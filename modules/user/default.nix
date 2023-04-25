{ config, path, pkgs, user, ... }:
rec {
  sops.secrets.mypwd.neededForUsers = true;

  users.users.${user} = {
    isNormalUser = true;

    shell = pkgs.fish;
    extraGroups = [ "wheel" ];

    passwordFile = config.sops.secrets.mypwd.path;
    openssh.authorizedKeys.keys = import /${path}/config/sshkeys.nix;
  };

  environment.persistence."/nix/persist".users.${user}.directories = [
    # Home
    "Desktop"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Videos"
    "Workspace"
    ".cache"
  ];
}