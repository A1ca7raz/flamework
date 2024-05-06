{ lib, config, ... }:
let
  useNetNS = lib.mkIf config.utils.netns.enable;

  inherit (config.lib.services.step-ca) ipAddrs;

  netnsService = "netns-veth-step.service";
in {
  utils.netns.bridge."0".ipAddrs = config.lib.vnet.ipAddrs;

  utils.netns.veth.step = {
    bridge = "0";
    netns = "step";
    ipAddrs = ipAddrs;
  };

  systemd.services.step-ca = useNetNS {
    after = [ netnsService ];
    bindsTo = [ netnsService ];
  };
}