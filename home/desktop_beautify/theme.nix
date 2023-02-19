{ util, pkgs, lib,  ... }:
with util; let
  IconTheme    = "Tela";
  ColorScheme  = "MyDark";
  CursorTheme  = "Bibata-Modern-Ice";
  kvantumTheme = "Breeze-Noir-Dark-Kvantum";

  _wc = wc_ "$HOME/.config/kscreenlockerrc" ["Greeter" "Wallpaper" "org.kde.potd" "General"];
  color = x: ".local/share/color-schemes/${x}.colors";
in
{
  home.packages = with pkgs; [ plasma5Packages.qtstyleplugin-kvantum ];

  home.activation.setupTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Application Style
    ${wc "kdeglobals" "KDE" "widgetStyle" "kvantum"}
    # Plasma Style
    ${wc "plasmarc" "Theme" "name" "Win11OS-dark"}
    ${wc "plasmarc" "Theme-plasmathemeexplorer" "name" "Win11OS-dark"}
    # Window decorations
    ${wc "kwinrc" "org.kde.kdecoration2" "theme" "Sierra Breeze Enhanced"}
    ${wc "kwinrc" "org.kde.kdecoration2" "library" "org.kde.sierrabreezeenhanced"}
    # Colors
    ${wc "kdeglobals" "General" "ColorScheme" ColorScheme}
    # Icons
    ${wc "kdeglobals" "Icons" "Theme" IconTheme}
    # Cursors
    ${wc "kcminputrc" "Mouse" "cursorTheme" CursorTheme}
    # Kvantum Theme
    ${wc "Kvantum/kvantum.kvconfig" "General" "theme" kvantumTheme}
    # Splash screen
    ${wc "ksplashrc" "KSplash" "Theme" "Arch-Splash"}

    # Screen Locker
    ${wc "kscreenlockerrc" "Daemon" "Autolock" "false"}
    ${wc "kscreenlockerrc" "Greeter" "WallpaperPlugin" "org.kde.potd"}
    ${_wc "Provider" "bing"}
    ${_wc "UpdateOverMeteredConnection" "1"}

    ## Window Border
    ${wc "kwinrc" "org.kde.kdecoration2" "BorderSize" "None"}
    ${wc "kwinrc" "org.kde.kdecoration2" "BorderSizeAuto" "false"}
    ## Titlebar Buttons
    ${wc "kwinrc" "org.kde.kdecoration2" "ButtonsOnLeft" "XM"}
    ${wc "kwinrc" "org.kde.kdecoration2" "ButtonsOnRight" "IA"}
    ${wc "kwinrc" "org.kde.kdecoration2" "CloseOnDoubleClickOnMenu" "true"}
    ## Use accent color From Wallpaper
    ${wc "kdeglobals" "General" "accentColorFromWallpaper" "true"}

    ## Cursor Animation
    # ?
    # ${wc "klaunchrc" "BusyCursorSettings" "Bouncing" "false"}

    ## Screen Edge Actions
    ${wc "kwinrc" "Effect-windowview" "BorderActivateClass" "7"}
    ${wc "kwinrc" "Effect-overview" "BorderActivate" "1"}
    ${wc "kwinrc" "Script-minimizeall" "BorderActivate" "3"}
  '';

  # gtk = {
  #   enable = true;
  #   theme.name = "Breeze";
  #   font.name = "Source Han Sans SC";
  #   cursorTheme.name = CursorTheme;
  #   iconTheme.name = IconTheme;
  # };

  home.file = {
    MyDarkColor = {
      target = color "MyDark";
      text = ''
        [ColorEffects:Disabled]
        Color=112,111,110
        ColorAmount=0
        ColorEffect=0
        ContrastAmount=0.65
        ContrastEffect=1
        IntensityAmount=0.1
        IntensityEffect=0

        [ColorEffects:Inactive]
        ChangeSelectionColor=true
        Color=112,111,110
        ColorAmount=0.025
        ColorEffect=2
        ContrastAmount=0.1
        ContrastEffect=2
        Enable=false
        IntensityAmount=0
        IntensityEffect=0

        [Colors:Button]
        BackgroundAlternate=45,57,63
        BackgroundNormal=5,14,25
        DecorationFocus=170,170,170
        DecorationHover=150,150,150
        ForegroundActive=255,128,224
        ForegroundInactive=160,160,160
        ForegroundLink=46,184,230
        ForegroundNegative=240,1,1
        ForegroundNeutral=255,221,0
        ForegroundNormal=255,255,255
        ForegroundPositive=128,255,128
        ForegroundVisited=255,102,102

        [Colors:Selection]
        BackgroundAlternate=0,188,212
        BackgroundNormal=0,188,212
        DecorationFocus=170,170,170
        DecorationHover=150,150,150
        ForegroundActive=255,128,224
        ForegroundInactive=160,160,160
        ForegroundLink=46,184,230
        ForegroundNegative=240,1,1
        ForegroundNeutral=255,221,0
        ForegroundNormal=255,255,255
        ForegroundPositive=128,255,128
        ForegroundVisited=255,102,102

        [Colors:Tooltip]
        BackgroundAlternate=0,0,0
        BackgroundNormal=0,0,0
        DecorationFocus=170,170,170
        DecorationHover=150,150,150
        ForegroundActive=255,128,224
        ForegroundInactive=225,225,225
        ForegroundLink=46,184,230
        ForegroundNegative=240,1,1
        ForegroundNeutral=255,221,0
        ForegroundNormal=255,255,255
        ForegroundPositive=128,255,128
        ForegroundVisited=255,102,102

        [Colors:View]
        BackgroundAlternate=5,14,25
        BackgroundNormal=5,14,25
        DecorationFocus=170,170,170
        DecorationHover=150,150,150
        ForegroundActive=255,128,224
        ForegroundInactive=160,160,160
        ForegroundLink=46,184,230
        ForegroundNegative=240,1,1
        ForegroundNeutral=255,221,0
        ForegroundNormal=255,255,255
        ForegroundPositive=128,255,128
        ForegroundVisited=255,102,102

        [Colors:Window]
        BackgroundAlternate=5,14,25
        BackgroundNormal=5,14,25
        DecorationFocus=170,170,170
        DecorationHover=150,150,150
        ForegroundActive=255,128,224
        ForegroundInactive=160,160,160
        ForegroundLink=46,184,230
        ForegroundNegative=240,1,1
        ForegroundNeutral=255,221,0
        ForegroundNormal=255,255,255
        ForegroundPositive=128,255,128
        ForegroundVisited=255,102,102

        [General]
        ColorScheme=KvAdaptaDark
        Name=MyDark
        shadeSortColumn=true

        [KDE]
        contrast=0

        [WM]
        activeBackground=5,14,25
        activeBlend=5,14,25
        activeForeground=255,255,255
        inactiveBackground=5,14,25
        inactiveBlend=5,14,25
        inactiveForeground=200,200,200
      '';
    };

    MyLightColor = {
      target = color "MyLight";
      text = ''
      '';
   };
  };
}