{ lib, config, ... }:
let
  inherit (config.lib.services.postgresql) ipAddrs;
  
  useNetNS = lib.mkIf config.utils.netns.enable;

  localIPs = [ "127.0.0.1" "::1" ];

  remoteIPs = lib.optionals
    config.utils.netns.enable
    lib.removeCIDRSuffixes ipAddrs;
in {
  # add support for netns
  utils.netns.veth.psql = {
    bridge = "0";
    netns = "psql";
    inherit ipAddrs;
  };

  systemd.services.postgresql = useNetNS {
    after = [ "netns-veth-psql.service" ];
    bindsTo = [ "netns-veth-psql.service" ];
    serviceConfig.NetworkNamespacePath = "/run/netns/psql";
  };

  services.postgresql = {
    settings.listen_addresses = with lib; mkForce (
      concatStringsSep
      ", "
      (localIPs ++ remoteIPs)
    );

    authentication = useNetNS ''
      host all all ${config.lib.subnet.v4Full} md5
      host all all ${config.lib.subnet.v6Full} md5
    '';
  };
}