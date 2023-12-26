{ self, desktop, ... }:
with self; let
  components = self.nixosModules.components;
  modules = self.nixosModules.modules;
in desktop {
  targetHost = "192.168.10.3";
  targetPort = 22;
  targetUser = "nomad";
  # system = "x86_64-linux";

  modules = with modules; [
    desktop_apps
    desktop_beautify
    desktop_config
    user.nomad
    overlayfile
  ] ++ (with components; [
    binary-cache-cn
    wayland
  ] ++ (with hardware; [
    amdcpu
    amdgpu
    bluetooth
    nvme
  ]));

  extraConfig = { ... }: {
    networking.hostName = "oxygenlaptop";
    environment.overlay.debug = false;
  };
}
