{ ... }:
{
  boot.loader.grub = {
    timeout = 2;
    enable = true;
    default = "saved";
    # devices = ["/dev/vda"];
  };
}