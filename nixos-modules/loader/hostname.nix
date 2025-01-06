{ lib, const, ... }:
if const.node ? hostName && const.node.hostName != null
then {
  networking.hostName = lib.mkDefault const.node.hostName;
}
else {}
