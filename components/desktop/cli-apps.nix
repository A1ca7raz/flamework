{ pkgs, ... }:
{
  # Android-Tools
  programs.adb.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];
}