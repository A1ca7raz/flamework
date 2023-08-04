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
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
      vaapiVdpau
    ];
    extraPackages32 = with pkgs; with driversi686Linux; [
      libvdpau-va-gl
      vaapiVdpau
    ];
  };
}
