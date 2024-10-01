{ self, lib, ... }:
{
  # targetPort = 22;
  targetUser = "nomad";
  system = "x86_64-linux";
  tags = [ lib.tags.desktop ];

  modules = with self.nixosModules.modules; [
    (desktop.exclude ["plasma"])

    hardware.fido
    hardware.bluetooth

    hosts.nodes

    nix

    programs.shell

    (system.boot.exclude ["console"])
    system.bootloader.efi.systemd
    system.home-manager
    system.misc
    system.network.base
    system.network.network-manager
    system.security.fido
    system.security.pki
    system.security.sudo
    system.security.oomd

    users
  ];
}
