{ pkgs, lib, path, ... }:
{
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "prohibit-password";
    ports = [ 22 ];
    hostKeys = [
      { path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519"; }
      { path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa"; }  
    ];

    # certAuth = lib.optionalAttrs (builtins.pathExists /etc/ssh/ssh_host_ed25519_key-cert.pub) {
    #   enable = true;
    #   hostCertificate = "/etc/ssh/ssh_host_ed25519_key-cert.pub";
    #   userCAKey = "/etc/ssh/CA_User_key.pub";
    # };
  };

  programs.ssh.package = pkgs.openssh_hpn;
}
