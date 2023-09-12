{
  components,
  modules,
  ...
}: {
  targetHost = "192.168.10.3";
  targetPort = 22;
  targetUser = "nomad";
  # system = "x86_64-linux";

  components.use = with components; [
    binary-cache-cn
    desktop
    wayland
  ] ++ (with hardware; [
    amdcpu
    amdgpu
    bluetooth
    nvme
  ]);

  modules.use = with modules; [
    common
    desktop_apps
    desktop_beautify
    desktop_config
    user.nomad
    overlayfile
  ];

  extraConfiguration = { ... }: {
    networking.hostName = "oxygenlaptop";
    environment.overlay.debug = false;
  };
}
