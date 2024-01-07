{ ... }:
{
  # for systemd-networkd
  systemd.network.networks.eth0 = {
    DHCP = "yes";
    matchConfig.Name = "eth0";
  };
}