{
  description = "Flamework 4";

  outputs = { ... }:
    let
      inherit (import ./lib.nix) imports;
    in {
    flakeModules = imports ./flake-modules;

    lib = import ./lib;
  };
}
