{ self, templates, ... }:
templates.desktop {
  targetHost = "192.168.10.3";
  targetPort = 22;
  targetUser = "nomad";
  # system = "x86_64-linux";

  modules = with self.nixosModules.modules; [
    constant.theme

    desktop.plasma

    hardware.amdcpu
    hardware.amdgpu
    hardware.logitech
    hardware.nvme
    hardware.tpm

    (programs.desktop.exclude [
      "networking.cloudflare-warp"
    ])
    services.client
    system.kernel.xanmod
    system.security.secureboot
    # system.security.kwallet
  ];

  extraConfig = { ... }: {
    networking.hostName = "oxygenlaptop";
    environment.overlay.debug = false;
  };
}