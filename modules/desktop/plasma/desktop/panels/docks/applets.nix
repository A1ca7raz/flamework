let
  regApplet = plugin: {
    immutability = "1";
    inherit plugin;
  };
in {
  kickOff = {
    _ = regApplet "org.kde.plasma.kickoff";
    confG = {
      compactMode = "true";
      favoritesDisplay = "1";
      favoritesPortedToKAstats = "true";
      icon = "distributor-logo-nixos";
      primaryActions = "3";
      showActionButtonCaptions = "false";
      systemFavorites = ''lock-screen\\,logout\\,save-session\\,switch-user\\,suspend\\,hibernate\\,reboot\\,shutdown'';
    };
  };

  colorizer = {
    _ = regApplet "luisbocanegra.panel.colorizer";
    confG = {
      blurPanelBgEnabled = "true";
      enableCustomPadding = "true";
      fgColorEnabled = "true";
      fgColorMode = "1";
      fgContrastFixEnabled = "true";
      fgShadowEnabled = "true";
      fgShadowRadius = "3";
      fgShadowX = "1";
      fgShadowY = "2";
      hideRealPanelBg = "true";
      hideWidget = "true";
      panelBgColorMode = "1";
      panelBgEnabled = "true";
      panelBgOpacity = "0.7";
      panelBgRadius = "24";
      panelOutlineColorMode = "1";
      panelOutlineWidth = "1";
      panelPadding = "10";
      panelShadowSize = "1";
      panelShadowX = "1";
      panelWidgets = "org.kde.plasma.kickoff,应用程序启动器,distributor-logo-nixos|luisbocanegra.panel.colorizer,Panel colorizer,desktop|org.kde.plasma.icontasks,图标任务管理器,preferences-system-windows";
      panelWidgetsWithTray = "org.kde.plasma.kickoff,应用程序启动器,distributor-logo-nixos|luisbocanegra.panel.colorizer,Panel colorizer,desktop|org.kde.plasma.icontasks,图标任务管理器,preferences-system-windows";
      widgetBgEnabled = "20";
    };
  };

  iconTasks = {
    _ = regApplet "org.kde.plasma.icontasks";
    confG.launchers = builtins.concatStringsSep "," [
      "preferred://filemanager"
      "preferred://browser"
      "applications:codium.desktop"
      "applications:spotify.desktop"
      "applications:org.telegram.desktop.desktop"
      "applications:systemsettings.desktop"
    ];
  };
}
