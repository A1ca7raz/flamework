{ ... }:
{
  boot.loader.grub = {
    enable = true;
    default = "saved";
    # devices = ["/dev/vda"];
  };
}