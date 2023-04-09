{ lib, ... }:
with lib; let
  util = (import ./fold.nix { inherit lib; }) //
    (import ./nix.nix { inherit lib; });
in rec {
  _mkModuleTree = type: dir:
    let
      _path = ./${dir};
      _dir = builtins.readDir _path;
      _scanner_once = lib.mapAttrs' (_recur _path) _dir;
      _scanner = dir: lib.mapAttrs' (_recur dir) (builtins.readDir dir);

      hasDefault = n: builtins.pathExists /${n}/default.nix;

      _recur = path: n: v:
        if v == "regular" && util.isNix n && type == "nix"
        then { name = util.removeNix n; value = import /${path}/${n}; }
        else if v == "directory" && type == "dir" && hasDefault /${path}/${n}
          then { name = n; value = import /${path}/${n}; }
          else if (v == "directory" && type == "nix") || (v == "directory" && type == "dir")
            then { name = n; value = _scanner /${path}/${n}; }
            else { name = util.removeNix n; value = {}; };
    in
      _scanner_once;

  mkModuleTreeFromFiles = _mkModuleTree "nix";
  mkModuleTreeFromDirs = _mkModuleTree "dir";
}