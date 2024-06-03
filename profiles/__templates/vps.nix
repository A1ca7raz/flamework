{ self, lib, ... }:
{
  targetPort = 48422;
  # targetUser = "nomad";
  system = "x86_64-linux";
  tags = [ lib.tags.server ];

  modules = with self.nixosModules.modules; [
    # hosts.nodes

    nix.settings

    programs.shell.misc
    programs.server

    services.server.openssh

    (system.boot.exclude ["console"])
    system.misc
    system.network.base
    system.network.headless
    system.network.systemd
    system.security.pki
    system.security.sudo
    system.security.oomd

    users.root
  ];
}