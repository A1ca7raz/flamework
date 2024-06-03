{ ... }:
{
  boot.loader = {
    timeout = 2;
    efi = {
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    grub = {
      efiSupport = true;
      efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      device = "nodev";
    };
  };

  imports = [ ../common.nix ];
}