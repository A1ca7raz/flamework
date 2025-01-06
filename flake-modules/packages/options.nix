{ lib, ... }:
let
  inherit (lib)
    mkOption
    types
  ;
in {
  options.flamework.packages = {
    pkgsPath = mkOption {
      type = types.path;
      description = "Path of package sets";
    };
  };
}
