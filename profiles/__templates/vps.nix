{ self, ... }:
{
  targetPort = 48422;
  # targetUser = "nomad";
  system = "x86_64-linux";

  modules = with self.nixosModules.modules; [
    nix.nixpkgs.config
    nix.settings

    programs.editorconfig
    programs.fish
    programs.misc

    services.server.openssh

    system.boot.boot
    system.misc
    system.network.base
    system.network.headless
    system.security.oomd
    system.security.sops
    system.security.sudo

    users.root
  ];
}