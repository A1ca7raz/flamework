{ config, lib, ... }:
let
  mkColmenaHive =
    metaConfig: nodes:
    # https://github.com/zhaofengli/colmena/blob/main/src/nix/hive/eval.nix
    with builtins; rec {
      __schema = "v0";
      inherit metaConfig nodes;

      toplevel = lib.mapAttrs (_: v: v.config.system.build.toplevel) nodes;
      deploymentConfig = lib.mapAttrs (_: v: v.config.deployment) nodes;
      deploymentConfigSelected = names: lib.filterAttrs (name: _: elem name names) deploymentConfig;
      evalSelected = names: lib.filterAttrs (name: _: elem name names) toplevel;
      evalSelectedDrvPaths = names: lib.mapAttrs (_: v: v.drvPath) (evalSelected names);
      introspect =
        f:
        f {
          inherit lib;
          pkgs = nixpkgs;
          nodes = uncheckedNodes;
        };
    };
in {
  # https://github.com/xddxdd/nur-packages/blob/master/flake-modules/auto-colmena-hive-v0_20241006.nix
  flake.colmenaHive = lib.optionalAttrs
    config.flamework.profiles.enableColmenaHive
    (mkColmenaHive
      { allowApplyAll = false; }
      config.flake.nixosConfigurations);
}
