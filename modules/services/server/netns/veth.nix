{ pkgs, config, lib, tools, ... }:
with lib; let
  cfg = config.utils.netns;

  inherit (tools) removeCIDRSuffixes;

  inherit (import ./types.nix) vethModule;
  vethType = types.submodule vethModule;
in {
  options.utils.netns.veth = mkOption {
    type = with types; attrsOf vethType;
    default = {};
    description = "Attribute set of secrets to enable";
  };

  config = mkIf (cfg.enable && cfg.veth != {}) {
    systemd.services = mapAttrs' (name: val: nameValuePair "netns-veth-${name}"(
      let
        _cfg = val;
        _mkDepBr = x: "netns-bridge@${x}.service";
        _mkDepNS = x: "netns@${x}.service";

        _mkDep = p: optional (p.ns != null) (
          if p.isBridge
          then _mkDepBr p.ns
          else _mkDepNS p.ns
        );

        deps = (_mkDep _cfg.p1) ++ (_mkDep _cfg.p2);

        op = optionalString;
        addIp = ns: addrs: i: foldl (acc: ip:
          ''
            ip${op (ns != null) " -n ${ns}"} addr add ${ip} dev veth${toString i}-${name}
          '' + acc
        ) "" addrs;

      in optionalAttrs _cfg.enable {
        description = "Named network namespace veth ${name}";
        bindsTo = deps;
        after = deps;
        path = [ pkgs.iproute2 ];

        unitConfig = {
          StopWhenUnneeded = true;
        };
 
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };

        preStop = ''
          ip link del veth0-${name}
        '';

        script = ''
          ip link add veth0-${name}${op (!_cfg.p1.isBridge && _cfg.p1.ns != null) " netns ${_cfg.p1.ns}"} type veth peer veth1-${name} ${op (_cfg.p2.ns != null && !_cfg.p2.isBridge) " netns ${_cfg.p2.ns}"}
        '' + (
          if _cfg.p1.isBridge
          then ''
            ip link set veth0-${name} master vnet-${_cfg.p1.ns}
          ''
          else addIp _cfg.p1.ns _cfg.p1.ipAddrs 0
        ) + (
          if _cfg.p2.isBridge
          then ''
            ip link set veth1-${name} master vnet-${_cfg.p2.ns}
          ''
          else addIp _cfg.p2.ns _cfg.p2.ipAddrs 1
        ) + ''
          ip${op (_cfg.p1.ns != null && !_cfg.p1.isBridge) " -n ${_cfg.p1.ns}"} link set veth0-${name} up
          ip${op (_cfg.p2.ns != null && !_cfg.p2.isBridge) " -n ${_cfg.p2.ns}"} link set veth1-${name} up
        '' + (op (_cfg.addDefaultRoute && _cfg.p1.isBridge) (foldl (acc: ip:
          ''
            ip -n ${_cfg.p2.ns} route add default via ${ip}
          '' + acc
        ) "" (removeCIDRSuffixes cfg.bridge.${_cfg.p1.ns}.ipAddrs)));
      }
    )) cfg.veth;
  };
}