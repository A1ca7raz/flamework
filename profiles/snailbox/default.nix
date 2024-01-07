{ self, templates, ... }:
templates.vps {
  targetHost = "192.168.10.11";
  targetPort = 48422;
  # targetUser = "nomad";
  # system = "x86_64-linux";

  modules = with self.nixosModules.modules; [
    hardware.intelcpu
    hardware.fido

    # services
    system.bootloader.efi.grub.local
    system.kernel.xanmod
  ];

  extraConfig = { ... }: {
    networking.hostName = "oxygenbox";
    environment.overlay.debug = false;
  };
}