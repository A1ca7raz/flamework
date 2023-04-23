{ lib, ... }:
let
  util = (import ./fold.nix { inherit lib; }) // (import ./nix.nix { inherit lib; });
in with util; {
  importsFiles = dir: foldFileIfExists dir []
    (x: y:
      if isNix x
      then [ /${dir}/${x} ] ++ y
      else y
    );

  importsFilesNotDefault = dir: foldFileIfExists dir []
    (x: y:
      if isNix x && ! isDefault x
      then [ /${dir}/${x} ] ++ y
      else y
    );

  importsDirs = dir: foldDirIfExists dir [] (x: y: [ /${dir}/${x} ] ++ y);
}