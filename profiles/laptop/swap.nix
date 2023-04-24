{ ... }:
let
  offset = 5066578;
in
{
  swapDevices = [
    { device = "/swap/swapfile"; }
  ];

  boot.resumeDevice = "/dev/mapper/block";
  boot.kernelParams = [ "resume_offset=${builtins.toString offset}" ];
}