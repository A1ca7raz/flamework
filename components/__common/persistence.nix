{ lib, self, ... }:
let
  mkExist = path: if (builtins.pathExists path) then [ path ] else [];
in {
  imports = [
    self.nixosModules.impermanence
  ];

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/cache"
      "/var/lib"
      "/var/log"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ] ++ mkExist /etc/ssh/ssh_host_ed25519_key-cert.pub
      ++ mkExist /etc/ssh/CA_User_key.pub
    ;
  };
}
