{ home, pkgs, ... }:
{
  home.packages = with pkgs; [
    yubico-piv-tool
    yubikey-manager4          # Canokeys cannot work on Version 5
    yubikey-manager-qt
    yubikey-personalization
  ];
}