{ lib, ... }:
with lib; let
  util = (import ./fold.nix { inherit lib; }) //
    (import ./nix.nix { inherit lib; });
in
{
  constant = util.foldGetFile ./constant {} (x: y:
    lib.recursiveUpdate (import ./constant/${x}) y
  );
}