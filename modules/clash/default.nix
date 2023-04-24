{ pkgs, ... }:
{
  services.clash = {
    enable = true;
    package = pkgs.clash-meta;
    configFile = "/home/nomad/.config/clash/clash.yaml";
    enableWebUi = true;
  };
}