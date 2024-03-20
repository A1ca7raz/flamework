{
  nixosModule = { tools, user, config, ... }:
    with tools; {
      utils.kconfig.files.kwinrc.items = [
        (mkItem "ModifierOnlyShortcuts" "Meta" "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu")
      ];

      utils.kconfig.files.lattedockrc.items = [
        (mkItem "General" "Number of Actions" "0")
        (mkItem "PlasmaThemeExtended" "outlineWidth" "1")
        (mkItem "UniversalSettings" "badges3DStyle" "false")
        (mkItem "UniversalSettings" "canDisableBorders" "true")
        (mkItem "UniversalSettings" "contextMenuActionsAlwaysShown" "_layouts,_preferences,_quit_latte,_separator1,_add_latte_widgets,_add_view")
        (mkItem "UniversalSettings" "inAdvancedModeForEditSettings" "true")
        (mkItem "UniversalSettings" "inConfigureAppletsMode" "true")
        (mkItem "UniversalSettings" "isAvailableGeometryBroadcastedToPlasma" "true")
        (mkItem "UniversalSettings" "launchers" "")
        (mkItem "UniversalSettings" "memoryUsage" "0")
        (mkItem "UniversalSettings" "metaPressAndHoldEnabled" "false")
        (mkItem "UniversalSettings" "mouseSensitivity" "2")
        (mkItem "UniversalSettings" "parabolicSpread" "3")
        (mkItem "UniversalSettings" "parabolicThicknessMarginInfluence" "1")
        (mkItem "UniversalSettings" "screenTrackerInterval" "1000")
        (mkItem "UniversalSettings" "showInfoWindow" "true")
        (mkItem "UniversalSettings" "singleModeLayoutName" "MyDock")
        (mkItem "UniversalSettings" "version" "2")
      ];

      environment.overlay = mkOverlayTree user {
        lattedockrc = {
          target = c "lattedockrc";
          source = config.utils.kconfig.files.lattedockrc.path;
        };
      };

      environment.persistence = mkPersistDirsTree user [
        (c "latte") (ls "latte")
      ];
    };

  homeModule = { pkgs, lib, tools, ... }: {
    home.packages = with pkgs; [
      latte-dock
      applet-window-buttons6
      # applet-virtual-desktop-bar-wayland  # FIXME: no KDE6 port
      # applet-window-appmenu               # FIXME: no KDE6 port
    ];

    # Autostart
    xdg.configFile.autostart_latte_override = {
      target = "systemd/user/app-org.kde.latte\\x2ddock@autostart.service.d/override.conf";
      text = ''
        [Service]
        Restart=on-failure
      '';
    };
  };
}