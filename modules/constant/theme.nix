let
  module = { pkgs, ... }:
    let
      mktc = { color, opacity, blur, noise ? "0" }: rec {
        inherit color;
        blur = toString blur;
        noise = toString noise;
        kvantumOpacity = toString opacity;
        windecoOpacity = toString (100 - opacity);
        konsoleOpacity = "0." + windecoOpacity;
      };
    in {
      lib.themeColor = {
        light = mktc {
          color = "";
          opacity = 36;
          blur = "";
          noise = "";
        };

        dark = mktc {
          color = "";
          opacity = 46;
          blur = "";
          noise = "";
        };
      };
      lib.theme = rec {
        ThemeColor = "Light";  # Dark&Light
        IconTheme = {
          package = pkgs.tela-icon-theme;
          name = "Tela-dracula-light";
        };
        CursorTheme = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
        };
        PlasmaTheme     = "Win11OS-light";
        ColorScheme     = "My${ThemeColor}";
        KvantumTheme    = "Breeze-Blur-${ThemeColor}";
        KonsoleProfile  = "${ThemeColor}.profile";
      };
  };
in {
  nixosModule = module;
  homeModule = module;
}