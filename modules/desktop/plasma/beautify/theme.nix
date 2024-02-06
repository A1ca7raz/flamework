{
  nixosModule = { tools, config, user, lib, ... }:
    with tools; let
      inherit (config.lib) themeColor;
      inherit (config.lib.theme)
        ThemeColor
        IconTheme
        CursorTheme
        PlasmaTheme
        ColorScheme
        KvantumTheme;
    mkcl = lib.foldl (acc: i: acc // {
      ${i} = {
        target = c i;
        source = config.utils.kconfig.files."${i}".path;
      };
    }) {};
    in {
      environment.overlay = mkOverlayTree user (mkcl [
        "plasmarc"
        # "sierrabreezeenhancedrc"
        "Kvantum/kvantum.kvconfig"
        "ksplashrc"
        "kscreenlockerrc"
      ]);

      utils.kconfig.rules = [
        # Application Style
        (mkRule "kdeglobals" "KDE" "widgetStyle" "kvantum")
        # Plasma Style
        (mkRule "plasmarc" "Theme" "name" PlasmaTheme)
        (mkRule "plasmarc" "Theme-plasmathemeexplorer" "name" "Win11OS-dark")
        # Window decorations
        (mkRule "kwinrc" "org.kde.kdecoration2" "theme" "Sierra Breeze Enhanced")
        (mkRule "kwinrc" "org.kde.kdecoration2" "library" "org.kde.sierrabreezeenhanced")
        (mkRule "sierrabreezeenhancedrc" "Windeco" "BackgroundOpacity" (
          if (ThemeColor == "Dark")
          then themeColor.dark.windecoOpacity
          else if (ThemeColor == "Light")
          then themeColor.light.windecoOpacity
          else "100"
        ))
        # Colors
        (mkRule "kdeglobals" "General" "ColorScheme" ColorScheme)
        # Icons
        (mkRule "kdeglobals" "Icons" "Theme" IconTheme.name)
        # Cursors
        (mkRule "kcminputrc" "Mouse" "cursorTheme" CursorTheme.name)
        # Kvantum Theme
        (mkRule "Kvantum/kvantum.kvconfig" "General" "theme" KvantumTheme)
        # Splash screen
        (mkRule "ksplashrc" "KSplash" "Theme" "Arch-Splash")

        # Screen Locker
        (mkRule "kscreenlockerrc" "Daemon" "Autolock" "false")
        (mkRule "kscreenlockerrc" "Greeter" "WallpaperPlugin" "org.kde.potd")
        (mkRule "kscreenlockerrc" ["Greeter" "Wallpaper" "org.kde.potd" "General"] "Provider" "bing")
        (mkRule "kscreenlockerrc" ["Greeter" "Wallpaper" "org.kde.potd" "General"] "UpdateOverMeteredConnection" "1")

        ## Window Border
        (mkRule "kwinrc" "org.kde.kdecoration2" "BorderSize" "None")
        (mkRule "kwinrc" "org.kde.kdecoration2" "BorderSizeAuto" "false")
        ## Titlebar Buttons
        (mkRule "kwinrc" "org.kde.kdecoration2" "ButtonsOnLeft" "XM")
        (mkRule "kwinrc" "org.kde.kdecoration2" "ButtonsOnRight" "IA")
        (mkRule "kwinrc" "org.kde.kdecoration2" "CloseOnDoubleClickOnMenu" "true")
        ## Use accent color From Wallpaper
        (mkRule "kdeglobals" "General" "accentColorFromWallpaper" "true")

        ## Cursor Animation
        # ?
        # (mkRule "klaunchrc" "BusyCursorSettings" "Bouncing" "false")

        ## Screen Edge Actions
        (mkRule "kwinrc" "Effect-windowview" "BorderActivateClass" "7")
        (mkRule "kwinrc" "Effect-overview" "BorderActivate" "1")
        (mkRule "kwinrc" "Script-minimizeall" "BorderActivate" "3")
      ];
    };

  homeModule = { pkgs, tools, config, lib, ... }:
    with tools; let
      inherit (config.lib.theme)
        IconTheme
        CursorTheme
        KonsoleProfile;

      konsole_path = "$HOME/.local/share/konsole";
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
    };
}


