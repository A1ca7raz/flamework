{ lib, user, config, ... }:
with lib; {
  imports = [
    ./buttons.nix
    ./wallpaper.nix
    ./monitors.nix
    ./panels.nix
  ];

  environment.overlay = mkOverlayTree user {
    desktop-appletsrc = {
      source = config.utils.kconfig.files.appletsrc.path;
      target = c "plasma-org.kde.plasma.desktop-appletsrc";
    };
  };
}