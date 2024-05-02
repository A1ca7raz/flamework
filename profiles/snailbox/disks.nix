{ ... }:
let
  ssdOptions = ["discard=async" "noatime" "nodiratime" "ssd" "compress=zstd:3" "space_cache=v2"];
in {
  fileSystems."/" = {
    fsType = "tmpfs";
    options = [ "defaults" "relatime" "mode=755" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/BOOT";
    fsType = "vfat";
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-partlabel/PERSIST";
    fsType = "btrfs";
    options = [ "subvol=/NIX" ] ++ ssdOptions;
  };

  fileSystems."/nix/persist" = {
    device = "/dev/disk/by-partlabel/PERSIST";
    fsType = "btrfs";
    options = [ "subvol=/PERSIST" ] ++ ssdOptions;
    neededForBoot = true;
  };

  # NOTE: DATA Drive
  # fileSystems."/mnt/data/0" = {
  #   device = "/dev/disk/by-label/DATA0";
  #   fsType = "btrfs";
  #   options = [ "subvol=/DATA0" "compress=zstd:3" ];
  #   neededForBoot = true;
  # };  
  # fileSystems."/mnt/data/1" = {
  #   device = "/dev/disk/by-label/DATA0";
  #   fsType = "btrfs";
  #   options = [ "subvol=/DATA1" "compress=zstd:3" ];
  #   neededForBoot = true;
  # };

  # fileSystems."/var/lib/ocis/storage/" = {
  #   device = "/mnt/data/1/ocis_storage";
  #   depends = [ "/mnt/data/1" ];
  #   fsType = "none";
  #   options = [ "bind" ];
  # };
}