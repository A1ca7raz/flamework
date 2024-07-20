{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    ciel-latest
    squashfsTools # necessary dep
  ];

  environment.persistence."/nix/persist".users.root = {
    home = lib.mkDefault  "/root";
    directories = [
      "ciel"
    ];
  };
}