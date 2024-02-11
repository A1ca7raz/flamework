{
  nixosModule = { tools, user, ... }:
    with tools; {
      utils.kconfig.files.kwinrc.items = [
        (mkItem "ModifierOnlyShortcuts" "Meta" "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu")
      ];

      environment.overlay = mkOverlayTree user {
        lattedockrc = {
          target = c "lattedockrc";
          source = ./lattedockrc;
        };
      };

      environment.persistence = mkPersistDirsTree user [
        (c "latte") (ls "latte")
      ];
    };

  homeModule = { pkgs, lib, tools, ... }: {
    home.packages = with pkgs; [
      latte-dock
      libsForQt5.applet-window-buttons
      applet-virtual-desktop-bar-wayland
      applet-window-appmenu
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