{ self, ... }:
{
  # targetPort = 22;
  targetUser = "nomad";
  system = "x86_64-linux";

  modules = with self.nixosModules.modules; [
    (desktop.exclude ["plasma"])

    hardware.fido
    hardware.bluetooth

    nix

    (programs.exclude ["desktop"])

    system.boot.initrd
    system.boot.performance
    system.boot.sysrq
    system.boot.troubleshooting
    system.bootloader.efi.systemd
    system.home-manager
    system.misc
    system.network.base
    system.network.network-manager
    system.security.fido
    system.security.oomd
    system.security.sops
    system.security.sudo

    users
  ];  
}