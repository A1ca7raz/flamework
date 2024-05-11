{ lib, var, ... }:
if var.host ? hostname && var.host.hostname != null
then { 
  networking.hostName = lib.mkDefault var.host.hostname;
}
else {}