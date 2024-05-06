{ lib, self, path, inputs, ... }:
{
  name,
  deployment,
  modules,
  nixosSystem,
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
      specialArgs = nixosSystem.specialArgs // { lib = nixosSystem.lib; };
    };
    ${name} = {
      deployment = deployment;
      imports = modules;
    };
  };
}