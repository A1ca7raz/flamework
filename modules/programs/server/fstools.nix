{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    e2fsprogs
    xfsprogs
  ];
}