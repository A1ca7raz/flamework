{ ... }:
{
  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];

  hardware.cpu.intel.updateMicrocode = true;
}