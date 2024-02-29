{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    my-nerd-font-pack

    fira-code-symbols
    font-awesome

    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji-blob-bin
    noto-fonts-extra
    sarasa-gothic
    source-code-pro
    source-han-mono
    source-han-sans
    source-han-serif
    wqy_microhei
    twemoji-color-font
  ];
}