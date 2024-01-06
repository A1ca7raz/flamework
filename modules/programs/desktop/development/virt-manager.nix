{ user, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.${user}.extraGroups = [ "libvirtd" ];
}
