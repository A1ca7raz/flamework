{
  nixosModule = { tools, user, ... }:
    with tools; mkOverlayModule user {
      lattedockrc = {
        target = c "lattedockrc";
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
          singleModeLayoutName=MyDock
          version=2
        '';
      };
    };

  homeModule = { pkgs, lib, tools, ... }: {
    home.packages = with pkgs; [
      latte-dock-nostartup
      libsForQt5.applet-window-buttons
      applet-virtual-desktop-bar-wayland
      applet-window-appmenu
    ];

    home.activation.setupLatteMeta = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${tools.wrapWC pkgs "kwinrc" "ModifierOnlyShortcuts" "Meta" "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu"}
    '';
  };
}