{ lib }:
{
  isNix = x: lib.hasSuffix ".nix" x;
  removeNix = x: lib.removeSuffix ".nix" x;
}