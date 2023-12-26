{ lib, ... }:
{
  name,
  nixosSystem,
  ...
}: {
  nixosConfigurations.${name} = lib.nixosSystem nixosSystem;
}