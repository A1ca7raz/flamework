{ lib, config, ... }:
let
  inherit (lib)
    foldGetDir
  ;

  inherit (import ./lib.nix lib)
    mapPackages
    callPackage
  ;

  cfg = config.flamework.packages;
  path = cfg.pkgsPath;
in {
  imports = [
    ./options.nix
  ];

  flake.overlays.pkgs = final: prev: {
    flameworkPackages = mapPackages
      (callPackage final lib)
      "function"
      path;
  };

  perSystem = { pkgs, ... }: {
    packages = foldGetDir
      path {}
      (pkg: acc:
        {
          "${pkg}" = pkgs.callPackage
            (import /${path}/${pkg})
            { inherit lib; };
        } // acc
      );
  };
}
