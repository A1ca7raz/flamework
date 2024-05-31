{ lib, var, ... }:
if var.host ? hostName && var.host.hostName != null
then { 
  networking.hostName = lib.mkDefault var.host.hostName;
}
else {}