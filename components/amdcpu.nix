{ ... }:
{
  boot.kernelParams = [
    "amd_pstate=passive"
    "amd_iommu=on"
    "iommu=pt"
  ];

  hardware.cpu.amd.updateMicrocode = true;
}