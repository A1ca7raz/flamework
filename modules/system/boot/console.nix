{ ... }:
{
  boot.kernelParams = [
    "console=ttyS0,115200" "earlyprintk=ttyS0"  # serial console
  ];
}