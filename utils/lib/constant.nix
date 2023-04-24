{ lib, ... }@args:
let
  util = import ./fold.nix args;
in {
  constant = util.foldGetFile ./constant {}
    (x: y: lib.recursiveUpdate (import ./constant/${x}) y);
}