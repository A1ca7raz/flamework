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
      lengthFirstMargin = "5";
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
    _ = regApplet "org.kde.plasma.appmenu";
    # confG = {
    #   containmentType = "Plasma";
    #   filterByActive = "false";
    #   filterByScreen = "true";
    #   spacing = "4";
    # };
  };

  panelSpacer._ = regApplet "org.kde.plasma.panelspacer";

  spacerExtended = {
    _ = regApplet "luisbocanegra.panelspacer.extended";
    confG = {
      middleClickAction = "kwin,Window Close";
      mouseWheelDownAction = "kwin,Window Unmaximize Or Minimize";
      mouseWheelUpAction = "kwin,Window Maximize";
      pressHoldAction = "kwin,Overview";
      showHoverBg = "false";
      showTooltip = "false";
      singleClickAction = "Disabled,Disable";
    };
  };

  systemTray = {
    _ = regApplet "org.kde.plasma.systemtray";
    conf = containmentId: {
      PreloadWeight = "60";
      SystrayContainmentId = containmentId;
    };
  };

  lockLogout = {
    _ = regApplet "org.kde.plasma.lock_logout";
    confG.show_lockScreen = "false";
  };

  digitalClock = {
    _ = regApplet "org.kde.plasma.digitalclock";
    confA = {
      # customDateFormat = ''yyyy.M.'<font color="#55ff55">'d'</font>' ddd'';
      customDateFormat = ''yyyy.M.d ddd'';
      dateDisplayFormat = "BesideTime";
      dateFormat = "custom";
      fixedFont = "true";
      fontFamily = "Source Han Sans SC";
      fontWeight = "400";
      showSeconds = "2";
      showSeparator = "false";
      use24hFormat = "0";
    };
  };

  kara = {
    _ = regApplet "org.dhruv8sh.kara";
    confg = {
      animationDuration = "180";
      spacing = "4";
      type = "0";
    };
    conftype1 = {
      t1activeHeight = "6";
      t1activeWidth = "18";
      t1height = "4";
      t1width = "8";
    };
  };

  plasmusicToolbar = {
    _ = regApplet "plasmusic-toolbar";
    confG = {
      albumCoverRadius = "25";
      choosePlayerAutomatically = "false";
      commandsInPanel = "false";
      fallbackToIconWhenArtNotAvailable = "true";
      maxSongWidthInPanel = "180";
      preferredPlayerIdentity = "Spotify";
      textScrollingBehaviour = "2";
      textScrollingSpeed = "2";
      useAlbumCoverAsPanelIcon = "true";
    };
  };

  betterWindowTitle = {
    _ = regApplet "plasma6-window-title-applet";
    confA = {
      altTxt = "";
      fillThickness = "true";
      fixedLength = "200";
      fontSize = "13";
      isBold = "true";
      lengthKind = "2";
      midSpace = "4";
      txt = "%a";
    };
    confBehavior = { filterByScreen = "true"; };
    confSubstitutions = {
      subsMatchApp = ''"Telegram Desktop","Gimp-.*","soffice.bin","Spotify.*","Kate.*","Dolphin .*","Thunderbird .*","Konsole .*","Google Chrome.*"'';
      subsMatchTitle = ''".*",".*",".*",".*",".*",".*",".*",".*",".*"'';
      subsReplace = ''"Telegram","Gimp","LibreOffice","Spotify","Kate","Dolphin","Thunderbird","Konsole","Chrome"'';
    };
  };

  # inlineClock = {
  #   _ = regApplet "org.kde.plasma.betterinlineclock";
  #   conf = {
  #     PreloadWeight = "60";
  #   };
  #   confA = {
  #     customDateFormat = ''yyyy.M.'<font color="#55ff55">'d'</font>' ddd'';
  #     dateFormat = "customDate";
  #     fixedFont = "true";
  #     fontSize = "17";
  #     showSeconds = "true";
  #     showSeparator = "false";
  #   };
  # };

  # eventCalendar = {
  #   _ = regApplet "org.kde.plasma.eventcalendar";
  #   conf = { PreloadWeight = "55"; };
  #   confG = {
  #     clockMaxHeight = "16";
  #     clockTimeFormat1 = "yyyy.M.'<font color=\"#55ff55\">'d'</font>' ddd A hh:mm:'<b><font color=\"#dd55dd\">'ss'</font></b>'";
  #     v71Migration = "true";
  #     v72Migration = "true";
  #   };
  # };
}
