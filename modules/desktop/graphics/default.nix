{ pkgs, ... }:
{
  services.xserver = {
    enable = true;  # SDDM requires services.xserver.enable to be true
    libinput.enable = true;
    libinput.touchpad = {
      horizontalScrolling = true;
      naturalScrolling = true;
      tapping = true;
      tappingDragLock = false;
    };
  };

  # hardware.steam-hardware.enable = true;

  hardware.opengl = with pkgs; {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = [
      libvdpau-va-gl
      vaapiVdpau
    ];
    extraPackages32 = with driversi686Linux; [
      libvdpau-va-gl
      vaapiVdpau
    ];
  };
}
