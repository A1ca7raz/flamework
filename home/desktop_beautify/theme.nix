{ util, pkgs, lib,  ... }:
with util; let
  ThemeColor = "Light";  # Dark&Light

  IconTheme      = "Tela";
  CursorTheme    = "Bibata-Modern-Ice";
  PlasmaTheme    = "Win11OS-light";
  ColorScheme    = "My${ThemeColor}";
  KvantumTheme   = "Breeze-Blur-${ThemeColor}";
  KonsoleProfile = "${ThemeColor}.profile"; 

  konsole_path = "$HOME/.local/share/konsole";
  _wc = wc_ "$HOME/.config/kscreenlockerrc" ["Greeter" "Wallpaper" "org.kde.potd" "General"];
in
{
  home.packages = with pkgs; [
    plasma5Packages.qtstyleplugin-kvantum
    dconf
  ];

  home.activation.setupTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Application Style
    ${wc "kdeglobals" "KDE" "widgetStyle" "kvantum"}
    # Plasma Style
    ${wc "plasmarc" "Theme" "name" PlasmaTheme}
    ${wc "plasmarc" "Theme-plasmathemeexplorer" "name" "Win11OS-dark"}
    # Window decorations
    ${wc "kwinrc" "org.kde.kdecoration2" "theme" "Sierra Breeze Enhanced"}
    ${wc "kwinrc" "org.kde.kdecoration2" "library" "org.kde.sierrabreezeenhanced"}
    ${wc "sierrabreezeenhancedrc" "Windeco" "BackgroundOpacity" (if (ThemeColor == "Dark") then "55" else if (ThemeColor == "Light") then "80" else "100")}
    # Colors
    ${wc "kdeglobals" "General" "ColorScheme" ColorScheme}
    # Icons
    ${wc "kdeglobals" "Icons" "Theme" IconTheme}
    # Cursors
    ${wc "kcminputrc" "Mouse" "cursorTheme" CursorTheme}
    # Kvantum Theme
    ${wc "Kvantum/kvantum.kvconfig" "General" "theme" KvantumTheme}
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

    ## Konsole Profile
    ln -sf ${konsole_path}/${KonsoleProfile} ${konsole_path}/Default.profile
  '';

  gtk = {
    enable = true;
    theme.name = "Breeze";
    font.name = "Source Han Sans SC";
    cursorTheme.name = CursorTheme;
    iconTheme.name = IconTheme;
  };
}