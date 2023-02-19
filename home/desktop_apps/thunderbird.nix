{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    birdtray
    thunderbird
  ];

  # xdg.configFile.birdtray = {
  #   target = "birdtray-config.json";
  #   source = /${config.sops.secrets.birdtray-config.path};
  # };

  # Autostart
  # thunderbird-appmenu
  # .mozilla/thunderbird
  # .cache/mozilla/thunderbird
  # .thunderbird (?)
  # .config/birdtray-config.json
}