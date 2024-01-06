{ tools, user, ... }:
with tools; let
  mk = x: {
    source = ./color-scheme/${x}.colors;
    target = ".local/share/color-schemes/${x}.colors";
  };
in
mkOverlayModule user {
  MyDarkColor = mk "MyDark";
  MyLightColor = mk "MyLight";
}