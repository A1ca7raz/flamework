{ ... }:
{
  systemd.oomd = {
    enable = true;
    enableRootSlice = true;
    enableUserServices = true;
    enableSystemSlice = true;
  };
}
