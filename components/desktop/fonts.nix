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