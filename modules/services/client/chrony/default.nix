{ ... }:
{
  services.chrony = {
    enable = true;
  };

  services.timesyncd.enable = false;
}
