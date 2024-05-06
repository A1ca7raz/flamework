{ lib, ... }:
with lib; {
  utils.kconfig.rules = [
    (mkRule "kdeglobals" "General" "font" "Source Han Sans SC,10,-1,5,50,0,0,0,0,0")
    (mkRule "kdeglobals" "General" "fixed" "Source Han Mono SC,10,-1,5,50,0,0,0,0,0")
    (mkRule "kdeglobals" "General" "smallestReadableFont" "Source Han Sans SC,10,-1,5,50,0,0,0,0,0")
    (mkRule "kdeglobals" "General" "toolBarFont" "Source Han Sans SC,9,-1,5,50,0,0,0,0,0")
    (mkRule "kdeglobals" "General" "menuFont" "Source Han Sans SC,9,-1,5,50,0,0,0,0,0")
    (mkRule "kdeglobals" "WM" "activeFont" "Source Han Sans SC,11,-1,5,50,0,0,0,0,0")
    (mkRule "kdeglobals" "General" "XftAntialias" "true")
    (mkRule "kdeglobals" "General" "XftSubPixel" "rgb")
    (mkRule "kdeglobals" "General" "XftHintStyle" "hintnone")
    (mkRule "kcmfonts" "General" "forceFontDPI" "102")
  ];
}