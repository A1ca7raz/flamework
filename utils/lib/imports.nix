{ lib, ... }:
let
  util = (import ./fold.nix { inherit lib; }) //
    (import ./nix.nix { inherit lib; });
in {
  importsFiles = dir: util.foldFileIfExists dir [] (
    x: y:
      if util.isNix x
      then [ /${dir}/${x} ] ++ y
      else y
  );

  importsDirs = dir: util.foldDirIfExists dir [] (x: y: [ /${dir}/${x} ] ++ y);
}