{ pkgs, config, lib, ... }:
with lib; let
  cfg = config.utils.netns;

  inherit (import ./types.nix) bridgeModule;
in {
  options.utils.netns.bridge = mkOption {
    type = with types; attrsOf (submodule bridgeModule);
    default = {};
    description = "Attribute set of secrets to enable";
  };

  config = mkIf (cfg.enable && cfg.bridge != {}) {
    systemd.services = {
      "netns-bridge@" = {
        description = "Named network namespace bridge %I";
        path = [ pkgs.iproute2 ];

        unitConfig = {
          StopWhenUnneeded = true;
        };

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStop = "${pkgs.iproute2}/bin/ip link del vnet-%i";
        };
        
        script = ''
          ip link add vnet-$1 type bridge
          ip link set dev vnet-$1 up
        '';
        scriptArgs = "%i";
      };
    } // (foldlAttrs (acc: name: val:
      {
        "netns-bridge@${name}" = {
          overrideStrategy = "asDropin";
          path = [ pkgs.iproute2 ];

          postStart = foldl (acc: ip:
            ''
              ip addr add ${ip} dev vnet-${name}
            '' + acc
          ) "" val.ipAddrs;
        };
      } // acc
    ) {} cfg.bridge);
  };
}