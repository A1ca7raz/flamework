{ lib, ... }:
{
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  boot = {
    tmp.useTmpfs = true;
    initrd.systemd.enable = true;
    kernelParams = [
      "panic=1" "boot.panic_on_fail"              # Troubleshooting
      "sysrq_always_enabled=1"                    # SysRQ
      "random.trust_cpu=on"                       # speed up random seed

      # Performence Improvement
      "nowatchdog"
      "mitigations=off"
    ];
  };
}