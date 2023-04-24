{ pkgs, ... }:
{
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };
  environment.persistence."/nix/persist".users.nomad.directories = [
    ".config/wireshark"
  ];
  users.users.nomad.extraGroups = [ "wireshark" ];
}