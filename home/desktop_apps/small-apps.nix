{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
  };

  home.packages = with pkgs; [
    audacity
    barrier
    drawio
    element-desktop
    fsearch
    gimp
    inkscape
    libqalculate
    logseq
    peek
    protonup-ng
    qalculate-qt
    vlc
    wpsoffice
    sbctl
    sops
    # telegram-archpatched
    tdesktop

    # Yubikey Toolkits
    yubico-piv-tool
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
  ];
}