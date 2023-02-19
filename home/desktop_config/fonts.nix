{ util, lib, ... }:
with util;
{
  home.activation.setupFonts = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${wc "kdeglobals" "General" "font" "Source Han Sans SC,10,-1,5,50,0,0,0,0,0"}
    ${wc "kdeglobals" "General" "fixed" "Source Han Mono SC,10,-1,5,50,0,0,0,0,0"}
    ${wc "kdeglobals" "General" "smallestReadableFont" "Source Han Sans SC,10,-1,5,50,0,0,0,0,0"}
    ${wc "kdeglobals" "General" "toolBarFont" "Source Han Sans SC,9,-1,5,50,0,0,0,0,0"}
    ${wc "kdeglobals" "General" "menuFont" "Source Han Sans SC,9,-1,5,50,0,0,0,0,0"}
    ${wc "kdeglobals" "WM" "activeFont" "Source Han Sans SC,11,-1,5,50,0,0,0,0,0"}
    ${wc "kdeglobals" "General" "XftAntialias" "true"}
    ${wc "kdeglobals" "General" "XftSubPixel" "rgb"}
    ${wc "kdeglobals" "General" "XftHintStyle" "hintnone"}
    ${wc "kcmfonts" "General" "forceFontDPI" "102"}
  '';

  fonts.fontconfig.enable = true;

  xdg.configFile.fontconfig = {
    target = "fontconfig/conf.d/10-myfont.conf";
    text = ''
      <?xml version='1.0' encoding='UTF-8' standalone='no'?>
      <fontconfig>
        <match target="font">
          <edit name="hinting" mode="assign">
            <bool>false</bool>
          </edit>
        </match>
        <match target="font">
          <edit name="hintstyle" mode="assign">
            <const>hintnone</const>
          </edit>
        </match>
        <match target="font">
          <edit name="rgba" mode="assign">
            <const>rgb</const>
          </edit>
        </match>
        <match target="font">
          <edit name="lcdfilter" mode="assign">
            <const>lcddefault</const>
          </edit>
        </match>
        <match target="font">
          <edit name="embeddedbitmap" mode="assign">
            <bool>false</bool>
          </edit>
        </match>
        <match target="font">
          <edit name="antialias" mode="assign">
            <bool>true</bool>
          </edit>
        </match>
      </fontconfig>
    '';
  };
}