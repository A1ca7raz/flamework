{ ... }:
{
  boot = {
    tmpOnTmpfs = true;
    loader.timeout = 3;
    
    kernelParams = [
      "panic=1" "boot.panic_on_fail"  # Troubleshooting
      "console=ttyS0,115200" "earlyprintk=ttyS0"  # serial console
      "sysrq_always_enabled=1"  # SysRQ
      "random.trust_cpu=on"  # speed up random seed
    ];
  };
}