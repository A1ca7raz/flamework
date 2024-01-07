{ lib, ... }:
let
  PORTS = [ 48422 ];
in {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = lib.mkForce "prohibit-password";
    };
    ports = PORTS;
    hostKeys = [
      { path = "/etc/ssh/ssh_host_ed25519_key"; type = "ed25519"; }
      { path = "/etc/ssh/ssh_host_rsa_key"; type = "rsa"; }
    ];
    extraConfig = ''
      TrustedUserCAKeys /etc/ssh/ssh_user_ca.pub
    '';
  };

  environment.persistence."/nix/persist".files = [
    "/etc/machine-id"
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_ed25519_key.pub"
    "/etc/ssh/ssh_host_rsa_key"
    "/etc/ssh/ssh_host_rsa_key.pub"
  ];

  environment.etc.sshUserCA = {
    target = "ssh/ssh_user_ca.pub";
    text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImEnstzrNsASzPhILySuXHjeyA84Hv0U1ini3w/4JBn";
  };
}