{ home, pkgs, ... }:
{
  home.packages = with pkgs; [
    sops
    age
  ];
}