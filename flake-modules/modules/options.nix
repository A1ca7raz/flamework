{ lib, ... }:
let
  inherit (lib)
    mkOption
    types
  ;
in {
  options.flamework.modules = {
    path = mkOption {
      type = types.path;
      description = "Path of module sets";
    };
  };
}
