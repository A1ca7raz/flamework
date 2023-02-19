{ util, lib, ... }:
with util;
{
  home.activation.setupKwinWindow = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ## Screen Edge Actions
    ${wc "kwinrc" "Effect-windowview" "BorderActivateClass" "7"}
    ${wc "kwinrc" "Effect-overview" "BorderActivate" "1"}
    ${wc "kwinrc" "Script-minimizeall" "BorderActivate" "3"}

    ## Normal Behavior
    ${wc "kdeglobals" "KDE" "SingleClick" "false"}
    ${wc "kdeglobals" "KDE" "ScrollbarLeftClickNavigatesByPage" "true"}

    ## Window Behavior
    ${wc "kwinrc" "Windows" "DelayFocusInterval" "0"}
    ${wc "kwinrc" "MouseBindings" "CommandTitlebarWheel" "Maximize/Restore"}
    ${wc "kwinrc" "MouseBindings" "CommandActiveTitlebar2" "Close"}
    ${wc "kwinrc" "MouseBindings" "CommandInactiveTitlebar2" "Close"}
    ${wc "kdeglobals" "General" "AllowKDEAppsToRememberWindowPositions" "false"}
    ${wc "kwinrc" "Windows" "ActivationDesktopPolicy" "BringToCurrentDesktop"}
    
    ## TabBox
    ${wc "kwinrc" "TabBox" "HighlightWindows" "false"}
    ${wc "kwinrc" "TabBox" "LayoutName" "thumbnail_grid"}
    ${wc "kwinrc" "TabBox" "ShowDesktopMode" "1"}
    ${wc "kwinrc" "TabBox" "ApplicationsMode" "1"}
    ${wc "kwinrc" "TabBox" "OrderMinimizedMode" "1"}
    ${wc "kwinrc" "TabBoxAlternative" "HighlightWindows" "false"}
    ${wc "kwinrc" "TabBoxAlternative" "ShowTabBox" "false"}

    ## KWin Scripts
    ${wc "kwinrc" "Plugins" "minimizeallEnabled" "true"}
    ${wc "kwinrc" "Plugins" "synchronizeskipswitcherEnabled" "true"}
  '';
}