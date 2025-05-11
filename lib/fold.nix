lib:
let
  inherit (builtins)
    readDir
    attrNames
    pathExists
  ;

  inherit (import ./nix.nix lib)
    isNix
  ;

  inherit (lib)
    hasPrefix
  ;

  isVisible = x: ! hasPrefix "_" x;
in rec {
  # _getListFromDir "directory/regular/nix" /path/to/dir
  _getListFromDir = type: dir:
  let
    _dir = readDir dir;
  in lib.fold
    (x: y:
      if (
        (type == "regular" || type == "directory") &&
        _dir.${x} == type &&
        isVisible x
      ) || (
        type == "nix" &&
        _dir.${x} == "regular" &&
        isNix x &&
        isVisible x
      )
      then [x] ++ y
      else y
    ) []
    (attrNames _dir);

  # _fold "directory/regular" /path/to/dir {} (x: y: rec { ${x} = import ./${x}; } // y);
  # _fold "directory/regular" /path/to/dir [] (x: y: [ ./${x} ] ++ y);
  _fold = type: dir: y: xy:
  let
    RESERVED_WORDS = [ "default" "default.nix" "__.nix" ];
  in
    lib.fold xy y
      (lib.subtractLists RESERVED_WORDS (_getListFromDir type dir));

  # foldGetFile /path/to/dir {} (x: y: rec { ${x} = import ./${x}; } // y);
  # foldGetFile /path/to/dir [] (x: y: [ ./${x} ] ++ y);
  foldGetFile = dir: y: xy: _fold "regular" dir y xy;

  # foldGetDir /path/to/dir {} (x: y: rec { ${x} = import ./${x}; } // y);
  # foldGetDir /path/to/dir [] (x: y: [ ./${x} ] ++ y);
  foldGetDir = dir: y: xy: _fold "directory" dir y xy;

  foldFileIfExists = x: y: z:
    if (pathExists x)
    then foldGetFile x y z
    else y;

  foldDirIfExists = x: y: z:
    if (pathExists x)
    then foldGetDir x y z
    else y;
}
