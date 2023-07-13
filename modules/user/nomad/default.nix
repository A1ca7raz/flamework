{ config, path, ... }: 
let 
  user = "nomad";
in rec {
  sops.secrets."${user}_pwd".neededForUsers = true;

  users.users.${user} = {
    extraGroups = [ "wheel" ];
    passwordFile = config.sops.secrets."${user}_pwd".path;
    openssh.authorizedKeys.keys = import /${path}/config/sshkeys.nix;
  };

  environment.persistence."/nix/persist".users.${user}.directories = [
    "Workspace"
    ".cache"
  ];
}