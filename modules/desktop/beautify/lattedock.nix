{ pkgs, ... }:
{
  home.packages = with pkgs; [
    latte-dock-nostartup
    libsForQt5.applet-window-buttons
    libsForQt5.plasma-applet-virtual-desktop-bar
    applet-window-appmenu
  ];

  xdg.configFile.lattedockrc = {
    target = "lattedockrc";
    text = ''
      [General]
      Number of Actions=0

      [PlasmaThemeExtended]
      outlineWidth=1

      [UniversalSettings]
      badges3DStyle=false
      canDisableBorders=true
      contextMenuActionsAlwaysShown=_layouts,_preferences,_quit_latte,_separator1,_add_latte_widgets,_add_view
      inAdvancedModeForEditSettings=true
      inConfigureAppletsMode=true
      isAvailableGeometryBroadcastedToPlasma=true
      launchers=
      memoryUsage=0
      metaPressAndHoldEnabled=false
      mouseSensitivity=2
      parabolicSpread=3
      parabolicThicknessMarginInfluence=1
      screenTrackerInterval=1000
      showInfoWindow=true
      singleModeLayoutName=MyPanel
      version=2
    '';
  };
}
