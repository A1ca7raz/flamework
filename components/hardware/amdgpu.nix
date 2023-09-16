{ pkgs, ... }:
{
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [
      "radeon.dpm=1"
    ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl = {
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  environment.systemPackages = [ pkgs.radeontop ];
}
