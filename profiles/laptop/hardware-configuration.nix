{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disks.nix
    ./swap.nix
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-amd" ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
