{ util, lib, self, path, ... }:
let
  module_path = /${path}/modules;
  module_list = util._getListFromDir "directory" module_path;
in
  lib.fold (x: y: rec { ${x} = import /${module_path}/${x}; } // y) {}
    (lib.subtractLists (import /${module_path}/default.nix).blacklistModules module_list)