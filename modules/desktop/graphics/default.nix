{ pkgs, ... }:
{
  services.libinput = {
    enable = true;
    touchpad = {
      horizontalScrolling = true;
      naturalScrolling = true;
      tapping = true;
      tappingDragLock = false;
    };
  };

  # hardware.steam-hardware.enable = true;

  hardware.graphics = with pkgs; {
    enable = true;
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
