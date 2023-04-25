{ components, modules, ... }:
{
  targetHost = "192.168.10.3";
  targetPort = 22;
  targetUser = "nomad";
  # system = "x86_64-linux";

  components.use = with components; [
    amdcpu
    amdgpu
    nvme
    binary-cache-cn
    desktop
  ];

  modules.use = with modules; [
    desktop
    user
  ];

  extraConfiguration = { ... }: {
    networking.hostName = "oxygenlaptop";
  };
}