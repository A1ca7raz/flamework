{ ... }:
{
  boot.kernelParams = [
    "amd_pstate=passive"
    "amd_iommu=off"       # NOTE: fix broken suspend
  ];

  hardware.cpu.amd.updateMicrocode = true;
}