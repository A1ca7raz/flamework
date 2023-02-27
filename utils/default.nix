lib: self:
let
  RESERVED_WORDS = [ "default" "default.nix" ];

  path = builtins.toPath ./..;
  inputs = self.inputs;
  pkgs = self.outputs.legacyPackages;

  util = (import ./lib) { inherit lib pkgs; };

  # Load Flake Utilities
  utils_in_flake = util.foldGetDir ./flakes {}
    (x: y: rec { ${x} = import ./flakes/${x} { inherit util lib self path inputs; };} // y );

  # Load Module Utilities
  utils_in_module = util.foldGetDir ./modules []
    (x: y: [ ./modules/${x} ] ++ y);

in utils_in_flake // rec {
  module.utils = { config, lib, util, self, path, inputs, ... }: {
    imports = utils_in_module;
  };
}
