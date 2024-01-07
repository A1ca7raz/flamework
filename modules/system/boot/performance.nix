{ ... }:
{
  boot.kernelParams = [
    # Performance Improvement
    "random.trust_cpu=on"                       # speed up random seed

    "nowatchdog" "mitigations=off"
  ];
}