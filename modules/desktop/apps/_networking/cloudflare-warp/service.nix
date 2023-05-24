{ pkgs, ... }:
{
  imports = [ ./cloudflare-warp.nix ];

  services.cloudflare-warp = {
    enable = true;
    certificate = ./Cloudflare_CA.cer;
  };
}