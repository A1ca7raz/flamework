{ lib, pkgs, ... }:
let
  foldGetFile = ((import ./fold.nix) { inherit lib pkgs; }).foldGetFile;
in
  (foldGetFile ./. {}
    (x: y:
      if lib.hasSuffix ".nix" x
      then ( import ./${x} ) { inherit lib pkgs; } // y
      else y
    )) // lib