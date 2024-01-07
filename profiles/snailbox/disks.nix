{ ... }:
let
  ssdOptions = ["discard=async" "noatime" "nodiratime" "ssd" "compress-force=zstd" "space_cache=v2"];


  mkRootMount = subvol: {
    device = "/dev/disk/by-partlabel/NIXOS";
    fsType = "btrfs";
    options = [ "subvol=/${subvol}" "compress-force=zstd" ];
  };
in {
  fileSystems."/" = {
    fsType = "tmpfs";
    options = [ "defaults" "relatime" "mode=755" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/BOOT";
    fsType = "vfat";
  };

  fileSystems."/nix" = mkRootMount "NIX";

  fileSystems."/nix/persist" = mkRootMount "PERSIST" // { neededForBoot = true; };

  fileSystems."/mnt/data/0" = {
    device = "/dev/disk/by-label/DATA0";
    fsType = "btrfs";
    options = [ "subvol=/DATA0" ] ++ ssdOptions;
  };

  fileSystems."/mnt/data/1" = {
    device = "/dev/disk/by-label/DATA1";
    fsType = "btrfs";
    options = [ "subvol=/DATA1" "compress-force=zstd" ];
  };
}