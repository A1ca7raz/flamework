{ ... }:
{
  # security.protectKernelImage = true;
  security.sudo = {
    enable = true;
    execWheelOnly = true;
  };
}