{ pkgs, ... }:
{
  fonts.enableDefaultPackages = false;
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    my-nerd-font-pack

    # corefonts
    # fira-code
    fira-code-symbols
    # fira-mono
    font-awesome
    hanazono
    # jetbrains-mono
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji-blob-bin
    noto-fonts-extra
    # roboto-mono
    sarasa-gothic
    source-code-pro
    source-han-mono
    source-han-sans
    source-han-serif
    # ubuntu_font_family
    # vistafonts
    # vistafonts-chs
    wqy_microhei
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Source Han Serif SC" "Blobmoji" ];
      sansSerif = [ "Source Han Sans SC" "Blobmoji" ];
      monospace = [ "Source Han Mono SC" "Blobmoji" ];
      emoji = [ "Blobmoji" ];
    };
    cache32Bit = true;
  };
}