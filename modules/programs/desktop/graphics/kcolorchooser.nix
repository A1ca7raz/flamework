{ home, pkgs, ... }:
{
  home.packages = [ pkgs.kdePackages.kcolorchooser ];
}