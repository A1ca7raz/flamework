{ config, lib, var, ... }:
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
      local = "/${var.subnet.domain}/";
      domain = var.subnet.domain;
      expand-hosts = true;

      no-resolv = true;

      # DHCP
      interface = "eth0";
      bind-dynamic = true;
      dhcp-range = [
        (mix var.subnet.ipv4DHCP)
        (mix [ "::100" "::1ff" "constructor:eth0" "ra-names" "slaac" ])
      ];
      dhcp-option = [
        "3,0.0.0.0" # Set default gateway
        # "6,0.0.0.0" # Set DNS servers to announce
      ];

      # Ipv6
      enable-ra = true;
    };
  };

  systemd.network.networks.eth0 = {
    networkConfig.IPForward = "yes";

    # Static IP for router
    address = [ "${var.host.privateIPv4}/24" "${var.host.privateIPv6}/64" ];
    matchConfig.Name = "eth0";
  };
}