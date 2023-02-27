{ pkgs, ... }:
{
  fonts.enableDefaultFonts = false;
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    my-nerd-font-pack

    corefonts
    fira-code
    fira-code-symbols
    fira-mono
    font-awesome
    hanazono
    jetbrains-mono
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji-blob-bin
    noto-fonts-extra
    roboto-mono
    sarasa-gothic
    source-code-pro
    source-han-mono
    source-han-sans
    source-han-serif
    ubuntu_font_family
    vistafonts
    vistafonts-chs
    wqy_microhei
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Source Han Serif SC" ];
      sansSerif = [ "Source Han Sans SC" ];
      monospace = [ "Source Han Mono SC" ];
      emoji = [ "Blobmoji" ];
    };
    cache32Bit = true;
  };
}