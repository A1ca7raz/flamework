{ home, pkgs, ... }:
{
  home.packages = with pkgs; [
    ciel
    squashfsTools # necessary dep
    aosc-scriptlets
  ];
}
