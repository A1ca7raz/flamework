{ home, pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.applet-window-buttons6
    applet-panel-colorizer
  ];
}
