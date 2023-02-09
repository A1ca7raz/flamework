{ config, pkgs, lib, ... }:
{
  services.nginx = {
    enable = true;
    enableReload = true;

    recommendedOptimisation  = true;
    recommendedGzipSettings  = true;
    recommendedProxySettings = true;
    recommendedTlsSettings   = true;
  };
}
