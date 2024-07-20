{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ciel-latest
  ];
}