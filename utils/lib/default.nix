{ lib }:
let
  foldGetFile = ((import ./fold.nix) { inherit lib; }).foldGetFile;
in
  (foldGetFile ./. {}
    (x: y:
      if lib.hasSuffix ".nix" x
      then ( import ./${x} ) { inherit lib; } // y
      else y
    )) // lib