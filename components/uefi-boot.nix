{ ... }:
{
  fileSystems."/" ={
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "mode=755"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = ["noatime" "nodiratime" "discard"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/NIXOS";
    fsType = "btrfs";
    options = [ "subvol=NIXOS" "discard" "noatime" "nodiratime" "ssd_spread" "compress-force=zstd" "space_cache=v2"];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-label/NIXOS";
    fsType = "btrfs";
    options = [ "subvol=PERSIST" "discard" "noatime" "nodiratime" "ssd_spread" "compress-force=zstd" "space_cache=v2"];
    neededForBoot = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Grub with EFI Support
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "nodev";
  #boot.loader.grub.efiSupport = true;
}