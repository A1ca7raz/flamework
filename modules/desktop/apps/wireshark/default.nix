{ user, pkgs, ... }:
rec {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };
  environment.persistence."/nix/persist".users.${user}.directories = [
    ".config/wireshark"
  ];
  users.users.${user}.extraGroups = [ "wireshark" ];
}