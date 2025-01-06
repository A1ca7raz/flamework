lib:
with lib; {
  isNix = hasSuffix ".nix";
  isDefault = x: x == "default.nix";
  removeNix = removeSuffix ".nix";
  addNix = x: x + ".nix";
  hasDefault = n: builtins.pathExists /${n}/default.nix;
}