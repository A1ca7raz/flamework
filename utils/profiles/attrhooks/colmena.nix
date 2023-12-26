{ lib, self, path, inputs, tools, ... }:
{
  name,
  deployment,
  modules,
  system,
  ...
}: {
  colmena = {
    meta = {
      nixpkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = lib.mapAttrsToList (n: v: v) (lib.attrByPath ["overlays"] {} self);
      };
      specialArgs = { inherit self path inputs tools; };
    };
    ${name} = {
      deployment = deployment;
      imports = modules;
    };
  };
}