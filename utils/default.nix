lib: self:
let
  RESERVED_WORDS = [ "default" "default.nix" ];

  path = builtins.toPath ./..;
  inputs = self.inputs;
  util = (import ./lib) { inherit lib; };
  constant = lib.recursiveUpdate (import ./lib/constant.nix { inherit lib; }).constant (
    if (builtins.pathExists /${path}/constant.nix)
    then (import /${path}/constant.nix)
    else {}
  );

  # Load Flake Utilities
  profiles = import ./profiles { inherit util lib self path inputs constant; };

  # Load Module Utilities
  module_utils = (import ./lib/fold.nix { inherit lib; }).foldGetDir ./modules []
    (x: y: [ ./modules/${x} ] ++ y);
in {
  inherit constant profiles;

  modules.utils = { ... }: {
    imports = module_utils;
  };
}
