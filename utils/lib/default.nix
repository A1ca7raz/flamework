{ lib, ... }@args:
let
  foldGetFile = (import ./fold.nix args).foldGetFile;
in
  (foldGetFile ./. {}
    (x: y:
      if lib.hasSuffix ".nix" x
      then ( import ./${x} ) { inherit lib; } // y
      else y
    )
  ) // lib