{ pkgs, config, path, ... }:
{
  utils.secrets.nomad_pwd.enable = true;
  sops.secrets.nomad_pwd.neededForUsers = true;

  users.users.nomad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "realtime" "tss" ];
    shell = pkgs.fish;

    # Authentication
    hashedPasswordFile = config.sops.secrets.nomad_pwd.path;
    openssh.authorizedKeys.keys = import /${path}/config/sshkeys.nix;
  };

  environment.persistence."/nix/persist".users.nomad.directories = [
    # Home
    ".cache" "Workspace"
    "Desktop" "Documents" "Downloads"
    "Music"   "Pictures"  "Videos"
  ];
}
