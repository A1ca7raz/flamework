lib:
let
  inherit (import ./fold.nix lib) foldGetFile;
  path = ../..;
in {
  constant = lib.recursiveUpdate
    (foldGetFile ./constant {}
      (x: y: lib.recursiveUpdate (import ./constant/${x}) y)
    )
    (
      if (builtins.pathExists /${path}/constant.nix)
      then (import /${path}/constant.nix)
      else {}
    );
}