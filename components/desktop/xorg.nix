{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    libinput.enable = true;
    libinput.touchpad = {
      horizontalScrolling = true;
      naturalScrolling = true;
      tapping = true;
      tappingDragLock = false;
    };
  };

  hardware.steam-hardware.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}