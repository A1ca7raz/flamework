{ ... }:
let
  pre = x: ".local/share/konsole/" + x;

  profile_tpl = n: ''
    [Appearance]
    AntiAliasFonts=true
    BoldIntense=true
    ColorScheme=Blur ${n}
    EmojiFont=Blobmoji,10,-1,5,50,0,0,0,0,0
    Font=SauceCodePro Nerd Font Mono,10.5,-1,5,57,0,0,0,0,0,Medium
    UseFontLineChararacters=true
    WordModeAttr=false
    WordModeBrahmic=false

    [Cursor Options]
    CursorShape=0
    UseCustomCursorColor=false

    [General]
    Command=fish
    Name=${n}
    Parent=FALLBACK/
    TerminalCenter=false
    TerminalColumns=100
    TerminalRows=30

    [Interaction Options]
    MiddleClickPasteMode=0
    TrimLeadingSpacesInSelectedText=false
    TrimTrailingSpacesInSelectedText=false
    TripleClickMode=0

    [Scrolling]
    HistoryMode=2

    [Terminal Features]
    BidiRenderingEnabled=true
    BlinkingCursorEnabled=true
    FlowControlEnabled=true
  '';
in {
  home.file = {
    konsole_profile_dark = {
      target = pre "Dark.profile";
      text = profile_tpl "Dark";
    };

    konsole_color_dark = {
      target = pre "Blur Dark.colorscheme";
      text = ''
        [Background]
        Color=5,14,23

        [BackgroundFaint]
        Color=5,14,23

        [BackgroundIntense]
        Color=5,14,23

        [Color0]
        Color=35,38,39

        [Color0Faint]
        Color=49,54,59

        [Color0Intense]
        Color=127,140,141

        [Color1]
        Color=237,21,21

        [Color1Faint]
        Color=120,50,40

        [Color1Intense]
        Color=192,57,43

        [Color2]
        Color=17,209,22

        [Color2Faint]
        Color=23,162,98

        [Color2Intense]
        Color=28,220,154

        [Color3]
        Color=246,116,0

        [Color3Faint]
        Color=182,86,25

        [Color3Intense]
        Color=253,188,75

        [Color4]
        Color=29,153,243

        [Color4Faint]
        Color=27,102,143

        [Color4Intense]
        Color=61,174,233

        [Color5]
        Color=155,89,182

        [Color5Faint]
        Color=97,74,115

        [Color5Intense]
        Color=142,68,173

        [Color6]
        Color=26,188,156

        [Color6Faint]
        Color=24,108,96

        [Color6Intense]
        Color=22,160,133

        [Color7]
        Color=255,255,255

        [Color7Faint]
        Color=99,104,109

        [Color7Intense]
        Color=255,255,255

        [Foreground]
        Color=255,255,255

        [ForegroundFaint]
        Color=239,240,241

        [ForegroundIntense]
        Color=255,255,255

        [General]
        Anchor=0.5,0.5
        Blur=true
        ColorRandomization=false
        Description=Blur Dark
        FillStyle=Tile
        Opacity=0.55
        Wallpaper=
        WallpaperOpacity=1
      '';
    };

    konsole_profile_light = {
      target = pre "Light.profile";
      text = profile_tpl "Light";
    };

    konsole_color_light = {
      target = pre "Blur Light.colorscheme";
      text = ''
        [Background]
        Color=255,255,255

        [BackgroundFaint]
        Color=239,240,241

        [BackgroundIntense]
        Color=255,255,255

        [Color0]
        Color=35,38,39

        [Color0Faint]
        Color=49,54,59

        [Color0Intense]
        Color=127,140,141

        [Color1]
        Color=237,21,21

        [Color1Faint]
        Color=120,50,40

        [Color1Intense]
        Color=192,57,43

        [Color2]
        Color=17,209,22

        [Color2Faint]
        Color=23,162,98

        [Color2Intense]
        Color=28,220,154

        [Color3]Breeze
        Color=246,116,0

        [Color3Faint]
        Color=182,86,25

        [Color3Intense]
        Color=253,188,75

        [Color4]
        Color=29,153,243

        [Color4Faint]
        Color=27,102,143

        [Color4Intense]
        Color=61,174,233

        [Color5]
        Color=155,89,182

        [Color5Faint]
        Color=97,74,115

        [Color5Intense]
        Color=142,68,173

        [Color6]
        Color=26,188,156

        [Color6Faint]
        Color=24,108,96

        [Color6Intense]
        Color=22,160,133

        [Color7]
        Color=252,252,252

        [Color7Faint]
        Color=99,104,109

        [Color7Intense]
        Color=255,255,255

        [Foreground]
        Color=35,38,39

        [ForegroundFaint]
        Color=49,54,59

        [ForegroundIntense]
        Color=0,0,0

        [General]
        Anchor=0.5,0.5
        Blur=true
        ColorRandomization=false
        Description=Blur Light
        FillStyle=Tile
        Opacity=0.8
        Wallpaper=
        WallpaperOpacity=1
      '';
    };
  };
}