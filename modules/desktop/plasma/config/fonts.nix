{
  nixosModule = { tools, ... }:
    with tools; {
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
    };
  
  homeModule = { ... }: {
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
  };
}