{ self, ... }:
{
  targetPort = 48422;
  # targetUser = "nomad";
  system = "x86_64-linux";

  modules = with self.nixosModules.modules; [
    nix.settings

    (programs.exclude ["desktop"])

    services.server.openssh

    (system.boot.exclude ["console"])
    system.misc
    (system.network.exclude ["network-manager"])
    (system.security.exclude ["fail2ban" "fido"])

    users.root
  ];
}