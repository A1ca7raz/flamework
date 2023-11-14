{ pkgs, ... }:
{
  fonts.enableDefaultPackages = false;
  fonts.fontDir.enable = true;
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

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Source Han Serif SC" "Twitter Color Emoji" "Blobmoji" ];
      sansSerif = [ "Source Han Sans SC" "Twitter Color Emoji" "Blobmoji" ];
      monospace = [ "Source Han Mono SC" "Twitter Color Emoji" "Blobmoji" ];
      emoji = [ "Twitter Color Emoji" "Blobmoji" ];
    };
    cache32Bit = true;
  };
}
