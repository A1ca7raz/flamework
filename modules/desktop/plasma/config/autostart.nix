{
  homeModule = { pkgs, ... }:
    let
      mkLink = x: {
        target = "autostart/${x}.desktop";
        source = ./autostart/${x}.desktop;
      };
    in {
      xdg.configFile = {
        autostart_birdtray = mkLink "birdtray";
        autostart_easyeffects = mkLink "easyeffects";
        autostart_keepassxc = mkLink "keepassxc";
        autostart_steam = mkLink "steam";
        autostart_yakuake = mkLink "yakuake";
        autostart_tg = mkLink "telegram";
      };

      xdg.configFile.autostart_latte_override = {
        target = "systemd/user/app-org.kde.latte\\x2ddock@autostart.service.d/override.conf";
        text = ''
          [Service]
          Restart=on-failure
        '';
      };
    };

  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "autostart")
    ];
}