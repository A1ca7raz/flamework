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
      };

      systemd.user.services.latte-dock-autostart =
        with pkgs; let
          lattePackage = latte-dock-nostartup;
        in {
          Unit = {
            Description = "Keep latte alive";
            After = "graphical-session.target";
            PartOf = "graphical-session.target";
          };
          Service = {
            ExecStop = "${procps}/bin/pkill latte";
            ExecStart = "${lattePackage}/bin/latte-dock";
            Type = "idle";
            Restart = "on-failure";
            Slice = "app.slice";
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
        };
    };

  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "autostart")
    ];
}