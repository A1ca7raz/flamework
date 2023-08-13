{ lib, ... }@args:
with lib; with builtins; let
  util = (import ./fold.nix args) // (import ./nix.nix args);
in with util; rec {
  _mkModuleTree = type: _path:
  let
    _dir = readDir _path;
    _scanner_once = mapAttrs' (_recur _path) _dir;
    _scanner = dir: mapAttrs' (_recur dir) (readDir dir);

    hasDefault = n: pathExists /${n}/default.nix;

    _recur = path: n: v:
    let
      forceImportFiles = p: x: y:
        if isNix x
        then { "${removeNix x}" = import /${p}/${x}; } // y
        else y;
    in
      if v == "regular" && isNix n && type == "nix"
      then { name = removeNix n; value = import /${path}/${n}; }
      else if (v == "directory" && hasDefault /${path}/${n} && (import /${path}/${n}/default.nix) == "import files")
      then { name = n; value = foldFileIfExists /${path}/${n} {} (forceImportFiles /${path}/${n}); }
      else if v == "directory" && type == "dir" && hasDefault /${path}/${n}
      then { name = n; value = import /${path}/${n}; }
      else if (v == "directory" && type == "nix") || (v == "directory" && type == "dir")
      then { name = n; value = _scanner /${path}/${n}; }
      else { name = removeNix n; value = {}; };
  in
    _scanner_once;

  mkModuleTreeFromFiles = _mkModuleTree "nix";
  mkModuleTreeFromDirs = _mkModuleTree "dir";
}