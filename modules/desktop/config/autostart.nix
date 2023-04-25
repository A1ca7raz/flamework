{ ... }:
let
  delay' = s: x: ''sh -c "sleep ${toString s}; exec ${x}"'';
  delay = delay' 2;
in {
  utils.startup = {
    keepassxc = delay' 10 "keepassxc";
    telegram = delay "env telegram-desktop -autostart";
    yakuake = delay "yakuake";
    latte-dock = delay "latte-dock";
    steam = delay "steam -silent";
    thunderbird = delay "birdtray";
    easyeffects = delay "easyeffects --gapplication-service";
    clash = delay' 10 "clash-verge";
  };
}