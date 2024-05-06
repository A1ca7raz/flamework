{ self, lib, templates, ... }:
templates.desktop {
  targetHost = "192.168.10.3";
  targetPort = 22;
  targetUser = "nomad";
  # system = "x86_64-linux";
  tags = with lib.tags; [
    local internal private
    laptop
  ];

  modules = with self.nixosModules.modules; [
    desktop.plasma

    hardware.amdcpu
    hardware.amdgpu
    hardware.deep_sleep
    hardware.logitech
    hardware.nvme
    hardware.tpm

    (programs.desktop.exclude [
      "networking.cloudflare-warp"
      "development.jetbrains"
    ])
    (services.client.exclude ["homepage"])
    system.kernel.xanmod
    system.security.secureboot
    # system.security.kwallet
  ];

  extraConfig = { ... }: {
    networking.hostName = "oxygenlaptop";
    environment.overlay.debug = false;
  };
}