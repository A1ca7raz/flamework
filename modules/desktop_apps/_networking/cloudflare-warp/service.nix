{ ... }:
{
  imports = [ ./cloudflare-warp.nix ];

  services.cloudflare-warp = {
    enable = false;
    certificate = ./Cloudflare_CA.cer;
  };
}