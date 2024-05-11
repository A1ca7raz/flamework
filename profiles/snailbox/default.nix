{ self, lib, templates, ... }:
let
  ip4 = "198.18.0.1";
  ip6 = "fcb7:25f7:5bf3:100::1";
in templates.vps {
  targetHost = ip4;
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

    system.bootloader.efi.grub.removable
    system.kernel.xanmod
  ];

  extraConfig = { ... }: {
    utils.netns.enable = true;

    systemd.network.networks.eth0 = {
      address = [ "${ip4}/24" "${ip6}/64" ];
      matchConfig.Name = "eth0";
    };

    lib.this = { inherit ip4 ip6; };    
  };
}