{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.efibootmgr ];
}