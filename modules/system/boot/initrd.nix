{ ... }:
{
  boot = {
    tmp.useTmpfs = true;
    initrd.systemd.enable = true;
  };
}