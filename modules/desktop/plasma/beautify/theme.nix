{ home, pkgs, tools, config, lib, ... }:
with tools; let
  inherit (config.lib) themeColor;

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

  konsole_path = "$HOME/.local/share/konsole";
  wc = wrapWC pkgs;
  wc_ = wrapWC_ pkgs;
  _wc = wc_ "$HOME/.config/kscreenlockerrc" ["Greeter" "Wallpaper" "org.kde.potd" "General"];
in {
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    dconf
    IconTheme.package
    CursorTheme.package
    kwin-dynamic-workspaces
  ];

  qt = {
    enable = true;
    platformTheme = "kde";
  };

  home.activation.setupTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Application Style
    ${wc "kdeglobals" "KDE" "widgetStyle" "kvantum"}
    # Plasma Style
    ${wc "plasmarc" "Theme" "name" PlasmaTheme}
    ${wc "plasmarc" "Theme-plasmathemeexplorer" "name" "Win11OS-dark"}
    # Window decorations
    ${wc "kwinrc" "org.kde.kdecoration2" "theme" "Sierra Breeze Enhanced"}
    ${wc "kwinrc" "org.kde.kdecoration2" "library" "org.kde.sierrabreezeenhanced"}
    ${wc "sierrabreezeenhancedrc" "Windeco" "BackgroundOpacity" (
      if (ThemeColor == "Dark")
      then themeColor.dark.windecoOpacity
      else if (ThemeColor == "Light")
      then themeColor.light.windecoOpacity
      else "100"
    )}
    # Colors
    ${wc "kdeglobals" "General" "ColorScheme" ColorScheme}
    # Icons
    ${wc "kdeglobals" "Icons" "Theme" IconTheme.name}
    # Cursors
    ${wc "kcminputrc" "Mouse" "cursorTheme" CursorTheme.name}
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

  home.sessionVariables.GTK_USE_PORTAL = "1";

  # gtk = {
  #   enable = true;
  #   theme.name = "Breeze";
  #   font.name = "Source Han Sans SC";
  #   cursorTheme.name = CursorTheme.name;
  #   iconTheme.name = IconTheme.name;
  # };
}
