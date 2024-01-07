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

    (programs.exclude ["desktop" "server"])

    (system.boot.exclude ["console"])
    system.bootloader.efi.systemd
    system.home-manager
    system.misc
    system.network.base
    system.network.network-manager
    (system.security.exclude ["fail2ban"])

    users
  ];
}