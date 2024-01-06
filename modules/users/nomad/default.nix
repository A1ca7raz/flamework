{ pkgs, config, path, ... }:
let
  user = "nomad";
in {
  sops.secrets."${user}_pwd".neededForUsers = true;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "realtime" "tss" ];
    shell = pkgs.fish;

    # Authentication
    hashedPasswordFile = config.sops.secrets."${user}_pwd".path;
    openssh.authorizedKeys.keys = import /${path}/config/sshkeys.nix;
  };

  environment.persistence."/nix/persist".users.${user}.directories = [
    # Home
    ".cache" "Workspace"
    "Desktop" "Documents" "Downloads"
    "Music"   "Pictures"  "Videos"
  ];
}
