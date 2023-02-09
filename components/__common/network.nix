{ ... }:
{
  networking = {
    firewall.enable = false;
    useDHCP = false;
  };

  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.rmem_max" = 2500000;
  };
}