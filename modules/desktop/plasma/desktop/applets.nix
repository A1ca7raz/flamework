let
  regApplet = plugin: {
    immutability = "1";
    inherit plugin;
  };
in {
  windowButtons = {
    _ = regApplet "org.kde.windowbuttons";
    confG = {
      containmentType = "Plasma";
      filterByScreen = "false";
      hiddenState = "EmptySpace";
      inactiveStateEnabled = "true";
      lengthFirstMargin = "5x";
      lengthLastMargin = "5";
      selectedScheme = "/etc/profiles/per-user/nomad/share/color-schemes/KvArc.colors";
      useCurrentDecoration = "false";
      visibility = "3";
    };
  };

  windowTitle = {
    _ = regApplet "org.kde.windowtitle";
    confG = {
      actionScrollMinimize = "false";
      capitalFont = "false";
      containmentType = "Plasma";
      filterActivityInfo = "false";
      filterByScreen = "true";
      iconFillThickness = "false";
      iconSize = "22";
      subsMatch = ''"Telegram Desktop","Gimp-.*","IntelliJ IDEA Ultimate Edition","Google Chrome","Pycharm Professional Edition","Dolphin .*","Kate .*","Thunderbird .*","Konsole .*"'';
      subsReplace = ''"Telegram","Gimp","IDEA","Chrome","Pycharm","Dolphin","Kate","Thunderbird","Konsole"'';
    };
  };

  windowAppMenu = {
    _ = regApplet "org.kde.windowappmenu";
    confG = {
      containmentType = "Plasma";
      filterByActive = "false";
      filterByScreen = "true";
      spacing = "4";
    };
  };

  panelSpacer._ = regApplet "org.kde.plasma.panelspacer";

  eventCalendar = {
    _ = regApplet "org.kde.plasma.eventcalendar";
    conf = { PreloadWeight = "55"; };
    confG = {
      clockMaxHeight = "16";
      clockTimeFormat1 = "yyyy.M.'<font color=\"#55ff55\">'d'</font>' ddd A hh:mm:'<b><font color=\"#dd55dd\">'ss'</font></b>'";
      v71Migration = "true";
      v72Migration = "true";
    };
  };

  systemTray = {
    _ = regApplet "org.kde.plasma.systemtray";
    conf = containmentId: {
      PreloadWeight = "60";
      SystrayContainmentId = containmentId;
    };
  };

  virtualDesktopBar1 = {
    _ = regApplet "org.kde.plasma.virtualdesktopbar";
    confP = {
      AddDesktopButtonShow = "false";
      DesktopButtonsHorizontalMargin = "7";
      DesktopButtonsSetCommonSizeForAll = "true";
      DesktopButtonsSpacing = "5";
      DesktopIndicatorsCustomColorForCurrentDesktop = "#00aa7f";
      DesktopIndicatorsCustomColorForDesktopsNeedingAttention = "#ffaa00";
      DesktopIndicatorsCustomColorForOccupiedIdleDesktops = "#ffffff";
      DesktopIndicatorsDistinctForDesktopsNeedingAttention = "true";
      DesktopIndicatorsStyleLineThickness = "4";
      DesktopLabelsBoldFontForCurrentDesktop = "true";
      DesktopLabelsCustomColor = "#000000";
      DesktopLabelsCustomFont = "CaskaydiaCove Nerd Font";
      DesktopLabelsCustomFontSize = "17";
      DesktopLabelsStyle = "1";
    };
  };
  virtualDesktopBar2 = {
    _ = regApplet "org.kde.plasma.virtualdesktopbar";
    confP = {
      AddDesktopButtonShow = "false";
      DesktopButtonsHorizontalMargin = "8";
      DesktopButtonsSetCommonSizeForAll = "true";
      DesktopButtonsSpacing = "5";
      DesktopButtonsVerticalMargin = "0";
      DesktopIndicatorsCustomColorForCurrentDesktop = "#00aa7f";
      DesktopIndicatorsCustomColorForDesktopsNeedingAttention = "#ffaa00";
      DesktopIndicatorsCustomColorForIdleDesktops = "#ffffff";
      DesktopIndicatorsDistinctForDesktopsNeedingAttention = "true";
      DesktopIndicatorsStyle = "1";
      DesktopIndicatorsStyleLineThickness = "5";
      DesktopLabelsBoldFontForCurrentDesktop = "true";
      DesktopLabelsCustomColor = "#000000";
      DesktopLabelsCustomFont = "CaskaydiaCove Nerd Font";
      DesktopLabelsCustomFontSize = "17";
      DesktopLabelsStyle = "1";
    };
  };
  separator = {
    _ = regApplet "org.kde.latte.separator";
    confG.lengthMargin = "4";
  };

  lockLogout = {
    _ = regApplet "org.kde.plasma.lock_logout";
    confG.show_lockScreen = "false";
  };

  latteSpacer = {
    _ = regApplet "org.kde.latte.spacer";
    confG = {
      containmentType = "Plasma";
      lengthPixels = "5";
    };
  };
}