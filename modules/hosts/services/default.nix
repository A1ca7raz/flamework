{ config, lib, const, ... }:
with lib;
if config.services.knot.enable
then {
  # TODO: Knot domains
} else {
  networking.hosts = mapAttrs'
    (n: v:
      nameValuePair
        (cidr (elemAt v.ipAddrs 0)).ip
        v.domains
    )
    const.services;
}
