{ tools, user, config, ... }:
with tools; let
  inherit (config.lib.theme) ColorScheme;
  mk = x: {
    source = ./schemes/${x}.colors;
    target = ".local/share/color-schemes/${x}.colors";
  };
in {
  environment.overlay = mkOverlayTree user {
    MyDarkColor = mk "MyDark";
    MyLightColor = mk "MyLight";
  };

  utils.kconfig.files.kdeglobals.items = [
    { g = "General"; k = "ColorScheme"; v = ColorScheme; }
  ];
}