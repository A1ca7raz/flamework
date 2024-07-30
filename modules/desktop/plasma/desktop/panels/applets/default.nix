{ home, pkgs, ... }:
{
  home.packages = with pkgs; [
    applet-window-buttons6
  ];
}
