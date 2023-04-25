{ home, pkgs, ... }:
{
  home.packages = with pkgs; [
    yubico-piv-tool
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
  ];
}