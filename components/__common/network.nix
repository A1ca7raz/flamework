{ ... }:
{
  networking = {
    firewall.enable = false;
    firewall.checkReversePath = false;
    nftables.enable = true;
    useDHCP = false;
    usePredictableInterfaceNames = true;
  };

  # boot.kernel.sysctl = {
  #   "net.ipv4.tcp_congestion_control" = "bbr";

  #   "net.ipv4.tcp_fastopen" = 3;
  # };
}