{ config, lib, ... }:
let
  mix = lib.concatStringsSep ","; 
in {
  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = true;

    settings = {
      # DNS Server
      listen-address = mix [
        "127.0.0.1" "::1"
        config.lib.this.ip4
        config.lib.this.ip6
      ];

      # Local Domain
      local = "/${config.lib.subnet.domain}/";
      domain = config.lib.subnet.domain;
      expand-hosts = true;

      no-resolv = true;

      # DHCP
      interface = "eth0";
      bind-dynamic = true;
      dhcp-range = [
        (mix config.lib.subnet.ipv4DHCP)
        (mix config.lib.subnet.ipv6DHCP)
      ];
      dhcp-option = [
        "3,0.0.0.0" # Set default gateway
        # "6,0.0.0.0" # Set DNS servers to announce
      ];

      # Ipv6
      enable-ra = true;
    };
  };
}