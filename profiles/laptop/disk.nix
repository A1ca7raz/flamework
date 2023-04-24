{ self, ... }:
let
  mountOptions = ["discard" "noatime" "nodiratime" "ssd_spread" "compress-force=zstd" "space_cache=v2"];

  mkRootMount = subvol: {
    device = "/dev/mapper/block";
    fsType = "btrfs";
    options = [ "subvol=/${subvol}" ] ++ mountOptions;
  };
in {
  fileSystems."/" = {
    fsType = "tmpfs";
    options = [ "defaults" "size=2G" "mode=755" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = ["noatime" "nodiratime" "discard"];
  };

  fileSystems."/swap" = {
    device = "/dev/mapper/block";
    fsType = "btrfs";
    options = [ "subvol=/SWAP" "noatime" "nodiratime" "ssd_spread" "space_cache=v2" ];
  };

  fileSystems."/nix" = mkRootMount "NIX";

  fileSystems."/nix/persist" = mkRootMount "PERSIST" // { neededForBoot = true; };

  boot = {
    initrd.luks.devices.block = {
      device = "/dev/disk/by-label/ROOT";
      bypassWorkqueues = true;
      crypttabExtraOpts = [ "fido2-device=auto" "discard" ];
    };
  };
}