let
  inherit (builtins)
    length
    split
    attrNames
    elemAt
    filter
    readDir
    foldl'
    pathExists
  ;
in rec {
  is = regex: str: length (split regex str) != 1;

  mapAttrs' = f: set: foldl'
    (acc: f': acc // f f' set.${f'})
    {}
    (attrNames set);

  isVisible = x: ! is "^_" (baseNameOf x);

  imports = path:
    let
      dir = readDir path;
    in foldl'
      (acc: n:
        if dir."${n}" == "directory" && isVisible n && pathExists /${path}/${n}/default.nix
        then acc // { ${n} = import /${path}/${n}; }
        else acc
      )
      {}
      (attrNames dir);
}
