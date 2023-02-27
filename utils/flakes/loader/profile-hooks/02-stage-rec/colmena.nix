{ util, lib, self, path, inputs, ... }:
{
  name,
  deployment,
  modules,
  ...
}:
rec {
  colmena = {
    meta = {
      nixpkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
        overlays = import /${path}/utils/flakes/loader/overlays.nix { inherit util path lib; };
      };
      specialArgs = { inherit util self path inputs; };
    };
    ${name} = {
      deployment = deployment;
      imports = modules;
    };
  };
}