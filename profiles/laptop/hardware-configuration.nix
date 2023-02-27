{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disk.nix
    ./swap.nix
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-amd" ];
  hardware.bluetooth.enable = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
