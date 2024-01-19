{ self, templates, ... }:
let
  ip4 = "198.18.0.1";
  ip6 = "fcb7:25f7:5bf3:100::1";
in templates.vps {
  targetHost = ip4;

  modules = with self.nixosModules.modules; [
    constant.subnet

    hardware.intelcpu
    hardware.fido

    # Infra
    services.server.infra.router
    services.server.netns
    services.server.infra.step-ca
    services.server.infra.caddy
    services.server.infra.redis
    services.server.infra.postgresql

    # Services
    # services.server.applications.gitea

    system.bootloader.efi.grub.removable
    system.kernel.xanmod
  ];

  extraConfig = { ... }: {
    networking.hostName = "oxygenbox";

    systemd.network.networks.eth0 = {
      address = [ "${ip4}/24" "${ip6}/64" ];
      matchConfig.Name = "eth0";
    };

    lib.this = { inherit ip4 ip6; };    
  };
}