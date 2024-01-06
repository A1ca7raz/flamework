{ self, ... }:
let
  components = self.nixosModules.components;
  modules = self.nixosModules.modules;
in {
  # targetPort = 22;
  # targetUser = "nomad";
  system = "x86_64-linux";

  modules = with modules; [
    common
  ] ++ (with components; [
    __common
    desktop
  ]);

  # users."username".modules = with self.nixosModules; [];

  # extraConfig = { ... }: {
  #   # ...
  # };
}