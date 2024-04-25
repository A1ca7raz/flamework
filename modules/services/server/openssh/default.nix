{ config, ... }:
let
  PORTS = [ 48422 ];
in {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = if config.lib.global.type == "server"
        then "prohibit-password"
        else "no";
    };
    ports = PORTS;
    hostKeys = [
      { path = "/etc/ssh/ssh_host_ed25519_key"; type = "ed25519"; }
      { path = "/etc/ssh/ssh_host_rsa_key"; type = "rsa"; }
    ];
    # extraConfig = ''
    #   TrustedUserCAKeys /etc/ssh/ssh_user_ca.pub
    # '';
  };

  # environment.etc.sshUserCA = {
  #   target = "ssh/ssh_user_ca.pub";
  #   text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImEnstzrNsASzPhILySuXHjeyA84Hv0U1ini3w/4JBn";
  # };
}