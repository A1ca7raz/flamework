{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disk.nix
    ./swap.nix
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];

  hardware.bluetooth.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.kernelParams = [
    "radeon.dpm=1"
    "amd_iommu=on"
    "iommu=pt"
  ];

  hardware.opengl = {
    extraPackages = [ pkgs.amdvlk ];
    # extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
