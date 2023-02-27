{ lib, ... }:
{
  name,
  nixosSystem,
  ...
}:
rec {
  nixosConfigurations = {
    ${name} = lib.nixosSystem nixosSystem;
  };
}