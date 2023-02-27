{ util, lib, self, path, inputs, ... }:
{
  name,
  system ? "x86_64-linux",
  activeModules ? [],
  components ? {},
  extraConfiguration ? {},
  ...
}:
{
  modules = [({ ... }: {
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
      overlays = [
        self.overlays.default
      ] ++ (import /${path}/utils/flakes/loader/overlays.nix { inherit util path lib; });
    };
  })];
}