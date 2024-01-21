{ home, pkgs, ... }:
{
  home.packages = with pkgs; [
    yubico-piv-tool
    yubikey-manager          # Canokeys cannot work on Version 5
    # yubikey-manager-qt     # broken
    yubikey-personalization
  ];
}