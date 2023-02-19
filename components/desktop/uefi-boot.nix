{ pkgs, ... }:
{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
    timeout = 0;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
}