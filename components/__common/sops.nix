{ path, ... }:
{
  sops = {
    age = {
      keyFile = "/var/lib/age.key";
      sshKeyPaths = [];
      generateKey = false;
    };
    gnupg.sshKeyPaths = [];
  };
}