{ lib, ... }:
{
  networking = {
    firewall.enable = lib.mkDefault false;
    firewall.checkReversePath = lib.mkDefault false;
    nftables.enable = lib.mkDefault true;
    useDHCP = false;
  };
}