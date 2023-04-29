{ components, modules, ... }:
{
  targetHost = "192.168.10.3";
  targetPort = 22;
  targetUser = "nomad";
  # system = "x86_64-linux";

  components.use = with components; [
    binary-cache-cn
    desktop
  ] ++ (with hardware; [
    amdcpu
    amdgpu
    bluetooth
    nvme
  ]);

  modules.use = with modules; [
    common
    desktop
    user
  ];

  extraConfiguration = { ... }: {
    networking.hostName = "oxygenlaptop";
  };
}