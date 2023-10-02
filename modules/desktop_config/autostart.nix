{ pkgs, ... }:
let
  delay' = s: x: ''sh -c "sleep ${toString s}; exec ${x}"'';
  delay = delay' 2;
in {
  utils.startup = {
    keepassxc = delay' 10 "keepassxc";
    # telegram = delay "env telegram-desktop -autostart";
    yakuake = delay "yakuake";
    steam = delay "steam -silent";
    thunderbird = delay "birdtray";
    easyeffects = delay "easyeffects --gapplication-service";
    # latte-dock = delay "latte-dock";
  };

  systemd.user.services.latte-dock-autostart = with pkgs; let
    lattePackage = latte-dock-nostartup; 
  in {
    Unit = {
      Description = "Keep latte alive";
      After = [ "plasma-workspace.target" "plasma-plasmashell.service" ];
    };
    Service = {
      ExecStop = "${procps}/bin/pkill latte";
      ExecStart = "${lattePackage}/bin/latte-dock";
      Type = "idle";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}