{ lib, ... }@args:
let
  util = (import ./fold.nix args) // (import ./nix.nix args);
in with util; {
  importsFiles = dir: foldFileIfExists dir []
    (x: y:
      if isNix x
      then [ /${dir}/${x} ] ++ y
      else y
    );

  importsDirs = dir: foldDirIfExists dir [] (x: y: [ /${dir}/${x} ] ++ y);

  importsFilesUser = user: dir: foldFileIfExists dir []
    (x: y:
      if isNix x
      then [ (other@{ pkgs, ... }: (import dir) (other // { inherit user; })) ] ++ y
      else y
    );
}