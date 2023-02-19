{ pkgs, path, util, ... }:
{
  home.packages = with pkgs; [
    (ark.override { unfreeEnableUnrar = true; })
    ghostwriter
    dolphin-nospace
    kate
    kcolorchooser
    kompare
    kdeconnect
    krita
    kteatime
    yakuake
  ];

  imports = util.importsFiles ./plasma-apps;
}