{ pkgs, ... }:
{
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [
      "amdgpu.vm_update_mode=3"
      "radeon.dpm=1"
    ];
  };

  hardware.graphics = {
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  environment.systemPackages = [ pkgs.radeontop ];
}
