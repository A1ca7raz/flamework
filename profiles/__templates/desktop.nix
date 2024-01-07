{ self, ... }:
{
  # targetPort = 22;
  targetUser = "nomad";
  system = "x86_64-linux";

  modules = with self.nixosModules.modules; [
    desktop.fonts
    desktop.graphics
    desktop.misc
    desktop.pipewire
    desktop.wayland

    hardware.fido
    hardware.bluetooth

    nix

    programs.editorconfig
    programs.fish
    programs.misc

    system.boot.boot
    system.bootloader.efi.systemd
    system.home-manager
    system.misc
    system.network
    system.security.fido
    system.security.oomd
    system.security.sops
    system.security.sudo

    users
  ];  
}