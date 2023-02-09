{ self, ... }:
let
  mountOptions = { mountOptions = ["discard" "noatime" "nodiratime" "ssd_spread" "compress-force=zstd" "space_cache=v2"];};
in {
  imports = [
    self.nixosModules.disko
  ];

  disko.enableConfig = true;
  disko.devices = {
    disk.vda = {
      type = "disk";
      device = "/dev/vda";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            name = "bios_grub";
            type = "partition";
            start = "0";
            end = "1M";
            part-type = "primary";
            flags = ["bios_grub"];
          }
          {
            name = "ROOT";
            type = "partition";
            start = "1M";
            end = "100%";
            part-type = "primary";
            bootable = true;
            content = {
              type = "btrfs";
              extraArgs = "-f";
              subvolumes = {
                "/boot" = mountOptions;
                "/nix" = mountOptions;
                "/persist" = mountOptions;
              };
            };
          }
        ];
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [ "defaults" "mode=755" ];
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
}