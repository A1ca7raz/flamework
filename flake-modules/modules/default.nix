{ lib, config, ... }:
let
  inherit (lib) foldGetDir;

  inherit (import ./lib lib)
    mkModuleTreeFromDirs
  ;

  cfg = config.flamework.modules;
in {
  imports = [
    ./options.nix
  ];

  flake = {
    # Load Module Utilities
    nixosModules.utils = {
      imports = foldGetDir
        ./../../nixos-modules
        []
        (x: y: [ ./../../nixos-modules/${x} ] ++ y);
    };

    modules = mkModuleTreeFromDirs cfg.path;
  };
}
