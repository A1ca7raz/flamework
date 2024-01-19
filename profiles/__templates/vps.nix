{ self, ... }:
{
  targetPort = 48422;
  # targetUser = "nomad";
  system = "x86_64-linux";

  modules = with self.nixosModules.modules; [
    constant.services

    nix.settings

    (programs.exclude ["desktop"])

    services.server.openssh

    (system.boot.exclude ["console"])
    system.misc
    system.network.base
    system.network.headless
    system.network.systemd
    (system.security.exclude ["fail2ban" "fido" "kwallet"])

    users.root
  ];
}