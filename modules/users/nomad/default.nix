{ pkgs, config, lib, var, ... }:
{
  utils.secrets.nomad_pwd.path = ./nomadpwd.enc.json;
  sops.secrets.nomad_pwd.neededForUsers = true;

  users.users.nomad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "realtime" "tss" ];
    shell = pkgs.fish;

    # Authentication
    hashedPasswordFile = config.sops.secrets.nomad_pwd.path;
    openssh.authorizedKeys.keys = var.sshkeys;
  };

  environment.persistence."/nix/persist".users.nomad.directories = [
    # Home
    ".cache"
    ".local/state"
    "Desktop"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Videos"
    "Workspace"
  ];

  programs.fish.enable = lib.mkDefault true;
}
