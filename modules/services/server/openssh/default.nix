{ lib, const, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = if lib.utils.isServer then "prohibit-password" else "no";
    };
    ports = [ const.port.ssh ];
    hostKeys = [
      { path = "/etc/ssh/ssh_host_ed25519_key"; type = "ed25519"; }
      { path = "/etc/ssh/ssh_host_rsa_key"; type = "rsa"; bits = 4096; }
    ];
    # extraConfig = ''
    #   TrustedUserCAKeys /etc/ssh/trusted_user_ca
    # '';
  };

  # environment.etc.sshUserCA = {
  #   target = "ssh/trusted_user_ca";
  #   text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImEnstzrNsASzPhILySuXHjeyA84Hv0U1ini3w/4JBn";
  # };
}
