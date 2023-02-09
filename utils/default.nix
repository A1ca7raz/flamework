lib: self:
let
  RESERVED_WORDS = [ "default" "default.nix" ];
  util = (import ./lib) { inherit lib; };
  path = ./..;
  
  # Load Flake Utilities
  utils_in_flake = util.foldGetDir ./flakes {}
    (x: y: rec { ${x} = import ./flakes/${x} { inherit util lib self path; };} // y );

  # Load Module Utilities
  utils_in_module = util.foldGetDir ./modules []
    (x: y: [ ./modules/${x} ] ++ y);

in utils_in_flake // rec {
  module.utils = { config, lib, util, self, path, ... }: {
    imports = utils_in_module;
  };
}
