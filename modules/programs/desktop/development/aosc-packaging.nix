{ home, pkgs, ... }:
{
  home.packages = with pkgs; [
    ciel-latest
    squashfsTools # necessary dep
    aosc-scriptlets
  ];
}
