{ lib, self, ... }:
{
  imports = [
    self.nixosModules.impermanence
  ];

  environment.persistence."/persist" = {
    directories = [
      "/var/log"
      "/var/lib"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ] ++ (if (builtins.pathExists /etc/ssh/ssh_host_ed25519_key-cert.pub)
      then ["/etc/ssh/ssh_host_ed25519_key-cert.pub"] else [])
      ++ (if (builtins.pathExists /etc/ssh/CA_User_key.pub)
      then ["/etc/ssh/CA_User_key.pub"] else [])
    ;
  };
}
