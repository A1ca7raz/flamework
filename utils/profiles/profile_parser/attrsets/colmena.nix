{ util, lib, self, path, inputs, constant, ... }:
{
  name,
  deployment,
  modules,
  system,
  ...
}:
rec {
  colmena = {
    meta = {
      nixpkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = lib.mapAttrsToList (n: v: v) (lib.attrByPath ["overlays"] {} self);
      };
      specialArgs = { inherit util self path inputs constant; };
    };
    ${name} = {
      deployment = deployment;
      imports = modules;
    };
  };
}