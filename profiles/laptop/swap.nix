{ ... }:
let
  offset = "533760";
in
{
  swapDevices = [
    { device = "/swap/swapfile"; }
  ];

  boot.resumeDevice = "/dev/mapper/block";
  boot.kernelParams = [ "resume_offset=${offset}" ];
}