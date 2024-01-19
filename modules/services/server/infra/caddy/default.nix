{ ... }:
{
  services.caddy = {
    enable = true;
    acmeCA = "https://pki.insyder/acme/x1/directory";
  };
}