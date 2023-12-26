lib:
let
  inherit (import ./fold.nix lib) foldGetFile;
in {
  constant = foldGetFile ./constant {}
    (x: y: lib.recursiveUpdate (import ./constant/${x}) y);
}