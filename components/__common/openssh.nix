{ lib, ... }:
{
  services.openssh = {
    enable = true;
    permitRootLogin = "prohibit-password";
    ports = [ 22 ];
    hostKeys = [{
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];

    # certAuth = lib.mkIf (builtins.pathExists /etc/ssh/ssh_host_ed25519_key-cert.pub) {
    #   enable = true;
    #   hostCertificate = "/etc/ssh/ssh_host_ed25519_key-cert.pub";
    #   userCAKey = "/etc/ssh/CA_User_key.pub";
    # };
  };

  users.users.root.openssh.authorizedKeys.keys = import ../../config/sshkeys.nix;

  users.mutableUsers = false;
}
