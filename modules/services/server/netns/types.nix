{
  bridgeModule = { name, config, lib, ... }:
    let
      inherit (lib) mkOption types;
    in {
      options = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "enable bridge";
        };

        ipAddrs = mkOption {
          type = with types; coercedTo str (x: [x]) (listOf str);
          default = [];
          description = "Ip Addresses assigned to the bridge";
        };
      };
    };

  vethModule = { name, config, lib, ... }:
    let
      cfg = config;
      inherit (lib) mkOption mkEnableOption types mkIf mkMerge;
      peer = {
        ns = mkOption {
          type = with types; nullOr str;
          default = null;
          description = "netns in the veth";
        };
        ipAddrs = mkOption {
          type = with types; coercedTo str (x: [x]) (listOf str);
          default = [];
          description = "Ip Addresses assigned to the endpoint";
        };
        isBridge = mkEnableOption "use bridge settings";
      };
    in {
      options = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "enable veth";
        };
        p1 = peer;
        p2 = peer;

        bridge = mkOption {
          type = with types; nullOr str;
          default = null;
        };
        ipAddrs = mkOption {
          type = with types; coercedTo str (x: [x]) (listOf str);
          default = [];
          description = "Ip Addresses assigned to the veth";
        };
        netns = mkOption {
          type = with types; nullOr str;
          default = null;
          description = "netns in the veth";
        };
        addDefaultRoute = mkOption {
          type = types.bool;
          default = true;
          description = "add default route";
        };
      };

      config = mkMerge [
        (mkIf (cfg.bridge != null) {
          p1.ns = cfg.bridge;
          p1.isBridge = true;
        })
        (mkIf (cfg.netns != null) {
          p2.ns = cfg.netns;
          p2.ipAddrs = cfg.ipAddrs;
        })
      ];
    }; 
}