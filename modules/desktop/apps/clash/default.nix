{ pkgs, ... }:
{
  services.clash = {
    enable = false;
    package = pkgs.clash-meta;
    configFile = "/home/nomad/.config/clash/clash.yaml";
    enableWebUi = true;
  };
}