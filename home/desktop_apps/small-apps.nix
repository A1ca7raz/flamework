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
    libnotify
    libqalculate
    logseq
    peek
    protonup-ng
    qalculate-qt
    vlc
    wpsoffice
    sbctl
    sops
    baidupcs-go
    # telegram-archpatched
    tdesktop

    # Yubikey Toolkits
    yubico-piv-tool
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization

    steam-run
  ];
}