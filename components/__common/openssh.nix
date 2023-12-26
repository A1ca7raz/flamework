{ ... }:
{
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "prohibit-password";
    ports = [ 22 ];
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
    ];
  };
}
