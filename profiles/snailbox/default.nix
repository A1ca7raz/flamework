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
    system.bootloader.efi.grub.removable
    system.kernel.xanmod
  ];

  extraConfig = { ... }: {
    networking.hostName = "oxygenbox";
    environment.overlay.debug = false;

    systemd.network.networks.eth0 = {
      address = [ "192.168.10.11/24" ];
      gateway = [ "192.168.10.1" ];
      matchConfig.Name = "eth0";
    };
  };
}