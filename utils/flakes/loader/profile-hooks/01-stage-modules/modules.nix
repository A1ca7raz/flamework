{ util, lib, self, path, inputs, ... }:
{
  name,
  system ? "x86_64-linux",
  activeModules ? [],
  components ? {},
  extraConfiguration ? {},
  ...
}:
let
  DEFAULT_MODULES = lib.forEach ((import /${path}/modules)).defaultModules (x: self.nixosModules.${x});
in {
  modules = DEFAULT_MODULES ++ activeModules;
}