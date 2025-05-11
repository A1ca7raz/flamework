lib:
let
  inherit (lib)
    mapAttrsToList
    isNix
    removeNix
    hasDefault
    hasPrefix
    flatten
  ;

  inherit (builtins)
    readDir
    listToAttrs
    mapAttrs
    isFunction
  ;
in rec {
  _flatPackages = _getter: path:
    let
      _scan_first = mapAttrsToList (_recur path) (readDir path);
      _scan = dir: mapAttrsToList (_recur dir) (readDir dir);

      _recur = path: n: v:
        let
          realpath = /${path}/${n};
        in
          if v == "directory" && ! hasPrefix "_" n  && hasDefault realpath
          then { name = n; value = _getter n realpath;}
          else if v == "regular" && ! hasPrefix "_" n  && isNix realpath
          then { name = removeNix n; value = _getter n realpath;}
          else if v == "directory" && ! hasPrefix "_" n
          then _scan realpath
          else [];
    in
      listToAttrs (flatten _scan_first);

  flatPackages = type:
    let
      _getter = n: p:
        if type == "function" then import p else p;
    in
      _flatPackages _getter;

  mapPackages = f: type: path: mapAttrs f (flatPackages type path);

  callPackage = pkgs: _lib: name: value:
    let
      package = if isFunction value then value else import value;
    in
      pkgs.callPackage package { lib = _lib; };
}
