{ lib, ... }:
{
  isNix = lib.hasSuffix ".nix";
  removeNix = lib.removeSuffix ".nix";
  addNix = x: x + ".nix";
}