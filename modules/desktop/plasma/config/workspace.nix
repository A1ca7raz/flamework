{ tools, ... }:
with tools; {
  utils.kconfig.rules = [
    ## Screen Edge Actions
    (mkRule "kwinrc" "Effect-windowview" "BorderActivateClass" "7")
    (mkRule "kwinrc" "Effect-overview" "BorderActivate" "1")
    (mkRule "kwinrc" "Script-minimizeall" "BorderActivate" "3")

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
}