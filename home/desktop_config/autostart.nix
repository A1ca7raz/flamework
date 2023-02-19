{ ... }:
let
  delay' = s: x: ''sh -c "sleep ${toString s}; exec ${x}"'';
  delay = delay' 2;
in
{
  utils.startup = {
    keepassxc = delay' 6 "keepassxc";
    telegram = delay "env telegram-desktop -autostart";
    yakuake = delay "yakuake";
    latte-dock = delay "latte-dock";
    # steam = "";
    thunderbird = delay "birdtray";
  };
}