{ ... }:
let
  offset = 5066578;
in
{
  swapDevices = [
    { device = "/swap/swapfile"; }
  ];

  boot.resumeDevice = "/dev/mapper/block";
  boot.kernelParams = [
    "resume_offset=${builtins.toString offset}"
    "acpi_rev_override=1"
    "acpi_osi=Linux"
    "mem_sleep_default=deep"
  ];
}
