{ ... }:
{
  boot.initrd.systemd.enableTpm2 = true;

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    applyUdevRules = true;
  };
}
