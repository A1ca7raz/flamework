{ pkgs, ... }:
let
  delay' = s: x: ''sh -c "sleep ${toString s}; exec ${x}"'';
  delay2 = delay' 2;
  delay5 = delay' 5;
  delay10 = delay' 10;
in {
  utils.startup = {
    keepassxc = delay10 "keepassxc";
    # telegram = delay2 "env telegram-desktop -autostart";
    yakuake = delay2 "yakuake";
    steam = delay' 20 "steam -silent";
    thunderbird = delay2 "birdtray";
    easyeffects = delay2 "easyeffects --gapplication-service";
  };

  systemd.user.services.latte-dock-autostart = with pkgs; let
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
}
