{ self, lib, templates, ... }:
let
  ipv4 = "198.18.0.1";
  ipv6 = "fcb7:25f7:5bf3:100::1";
in templates.vps {
  targetHost = ipv4;
  hostName = "oxygenbox";
  tags = with lib.tags; [
    local internal private
  ];

  modules = with self.nixosModules.modules; [
    hardware.intelcpu

    services.server.domains

    # # Infra
    services.server.infra.router
    # services.server.infra.step-ca
    # services.server.infra.caddy
    # services.server.infra.redis
    # services.server.infra.postgresql

    # # Services
    # services.server.applications.gitea
    # services.server.applications.ocis

    system.network.netns
    system.bootloader.efi.grub.removable
    system.kernel.xanmod
  ];

  args = {
    privateIPv4 = ipv4;
    privateIPv6 = ipv6;
  };
}