{ ... }:
let
  ssdOptions = ["discard=async" "noatime" "nodiratime" "ssd" "compress-force=zstd" "space_cache=v2"];
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
    device = "/dev/disk/by-label/PERSIST";
    fsType = "btrfs";
    options = [ "subvol=/NIX" "compress-force=zstd" ];
  };

  fileSystems."/nix/persist" = {
    device = "/dev/disk/by-label/PERSIST";
    fsType = "btrfs";
    options = [ "subvol=/PERSIST" ] ++ ssdOptions;
    neededForBoot = true;
  };

  fileSystems."/mnt/data/0" = {
    device = "/dev/disk/by-label/DATA0";
    fsType = "btrfs";
    options = [ "subvol=/DATA0" "compress-force=zstd" ];
    neededForBoot = true;
  };  
  fileSystems."/mnt/data/0_local" = {
    device = "/dev/disk/by-label/DATA0";
    fsType = "btrfs";
    options = [ "subvol=/DATA0_LOCAL" "compress-force=zstd" ];
    neededForBoot = true;
  };
  fileSystems."/var/lib/ocis/storage/users/uploads" = {
    device = "/mnt/data/0_local/ocis_uploads";
    depends = [ "/mnt/data/0_local" ];
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/mnt/data/minio/0" = {
    device = "/dev/disk/by-label/MINIO_0";
    fsType = "xfs";
    options = [ "defaults" "noatime" ];
    neededForBoot = true;
  };
}