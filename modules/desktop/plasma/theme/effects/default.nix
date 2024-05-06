{
  nixosModule = { config, lib, ... }:
    let
      inherit (lib) mkRule;
      kwinrc = mkRule "kwinrc";
    in {
      utils.kconfig.rules = [
        ## Desktop Effects
        (kwinrc "Plugins" "blurEnabled" "true")
        (kwinrc "Effect-blur" "BlurStrength" "10")
        (kwinrc "Effect-blur" "NoiseStrength" "11")
        (kwinrc "Plugins" "contrastEnabled" "true")
        (kwinrc "Plugins" "dynamic_workspacesEnabled" "true")
        (kwinrc "Plugins" "kwin4_effect_eyeonscreenEnabled" "true")
        (kwinrc "Plugins" "kwin4_effect_windowapertureEnabled" "false")
        (kwinrc "Plugins" "kwin4_effect_dimscreenEnabled" "true")
        (kwinrc "Effect-kwin4_effect_scale" "InScale" "0.3")
        (kwinrc "Effect-kwin4_effect_scale" "OutScale" "0.3")
        (kwinrc "Effect-slide" "HorizontalGap" "0")
        (kwinrc "Effect-slide" "VerticalGap" "0")
        (kwinrc "Effect-slide" "SlideDocks" "true")

        ## Screen Locker
        (mkRule "kscreenlockerrc" "Daemon" "Autolock" "false")
        (mkRule "kscreenlockerrc" "Greeter" "WallpaperPlugin" "org.kde.potd")
        (mkRule "kscreenlockerrc" ["Greeter" "Wallpaper" "org.kde.potd" "General"] "Provider" "bing")
        (mkRule "kscreenlockerrc" ["Greeter" "Wallpaper" "org.kde.potd" "General"] "UpdateOverMeteredConnection" "1")

        ## Use accent color From Wallpaper
        (mkRule "kdeglobals" "General" "accentColorFromWallpaper" "true")

        ## Screen Edge Actions
        (kwinrc "Effect-windowview" "BorderActivateClass" "7")
        (kwinrc "Effect-overview" "BorderActivate" "1")
        (kwinrc "Script-minimizeall" "BorderActivate" "3")

        ## Normal Behavior
        (mkRule "kdeglobals" "KDE" "SingleClick" "false")
        (mkRule "kdeglobals" "KDE" "ScrollbarLeftClickNavigatesByPage" "true")

        ## Window Behavior
        (mkRule "kwinrc" "Windows" "DelayFocusInterval" "0")
        (mkRule "kwinrc" "MouseBindings" "CommandTitlebarWheel" "Maximize/Restore")
        (mkRule "kwinrc" "MouseBindings" "CommandActiveTitlebar2" "Close")
        (mkRule "kwinrc" "MouseBindings" "CommandInactiveTitlebar2" "Close")
        (mkRule "kdeglobals" "General" "AllowKDEAppsToRememberWindowPositions" "false")
        (mkRule "kwinrc" "Windows" "ActivationDesktopPolicy" "BringToCurrentDesktop")
        
        ## TabBox
        (mkRule "kwinrc" "TabBox" "HighlightWindows" "false")
        (mkRule "kwinrc" "TabBox" "LayoutName" "thumbnail_grid")
        (mkRule "kwinrc" "TabBox" "ShowDesktopMode" "1")
        (mkRule "kwinrc" "TabBox" "ApplicationsMode" "1")
        (mkRule "kwinrc" "TabBox" "OrderMinimizedMode" "1")
        (mkRule "kwinrc" "TabBoxAlternative" "HighlightWindows" "false")
        (mkRule "kwinrc" "TabBoxAlternative" "ShowTabBox" "false")

        ## KWin Scripts
        (mkRule "kwinrc" "Plugins" "minimizeallEnabled" "true")
        (mkRule "kwinrc" "Plugins" "synchronizeskipswitcherEnabled" "true")
      ];
    };

  homeModule = { pkgs, ... }: {
    # home.packages = [ pkgs.kwin-dynamic-workspaces ];
  };
}