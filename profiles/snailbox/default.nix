{ self, templates, ... }:
let
  ip4 = "198.18.0.1";
  ip6 = "fcb7:25f7:5bf3:100::1";
in templates.vps {
  targetHost = ip4;

  modules = with self.nixosModules.modules; [
    hardware.intelcpu
    hardware.fido

    # Infra
    services.server.router
    services.server.netns
    services.server.infra.step-ca
    services.server.infra.caddy
    services.server.infra.postgresql

    # Services
    # services.server.gitea

    system.bootloader.efi.grub.removable
    system.kernel.xanmod
  ];

  extraConfig = { ... }: {
    networking.hostName = "oxygenbox";

    systemd.network.networks.eth0 = {
      address = [ "${ip4}/24" "${ip6}/64" ];
      networkConfig = {
        IPForward = "yes";
      };
      matchConfig.Name = "eth0";
    };

    lib.this = { inherit ip4 ip6; };
    lib.subnet = {
      v4 = "198.18.0.0/24";
      v4Full = "198.18.0.0/15";
      v6 = "fcb7:25f7:5bf3:100::/56";
      v6Full = "fcb7:25f7:5bf3::/48";
      ipv4DHCP = [ "198.18.0.2" "198.18.0.50" "255.255.255.0" "12h" ];
      ipv6DHCP = [ "::100" "::1ff" "constructor:eth0" "ra-names" "slaac" ];
      domain = "lab";
    };
  };
}