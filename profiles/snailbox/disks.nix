{ ... }:
let
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
}