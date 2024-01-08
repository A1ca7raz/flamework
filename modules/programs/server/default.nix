{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    efibootmgr
    sops
    age
    e2fsprogs
  ];
}