{ config, lib, ... }:
let
  mix = lib.concatStringsSep ","; 
in {
  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = true;

    # for Snailbox only
    settings = {
      # DNS Server
      listen-server = mix [
        "127.0.0.1" "::1"
        "127.0.0.53"
        config.lib.this.ipv4Addr
        config.lib.this.ipv6Addr
      ];

      # Local Domain
      local = "/lab/";
      domain = "lab";
      expand-hosts = true;

      # DHCP
      interface = "eth0";
      bind-interfaces = true;
      dhcp-range = [
        (mix config.lib.subnet.ipv4Range)
        (mix config.lib.subnet.ipv6Range)
      ];
      dhcp-option = [
        "3,0.0.0.0" # Set default gateway
        "6,0.0.0.0" # Set DNS servers to announce
      ];
    };
  };

  services.radvd = {
    enable = true;
    config = ''
      interface LAN {
        AdvSendAdvert on;
        MinRtrAdvInterval 3;
        MaxRtrAdvInterval 10;
        prefix ::/64 {
          AdvOnLink on;
          AdvAutonomous on;
          AdvRouterAddr on;
        };
      };

      RDNSS ${config.lib.this.ip6} {};
    '';
  };
}