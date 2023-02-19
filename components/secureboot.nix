{ self, lib, ... }:
let
  secureboot_bundle_path = "/nix/persist/secureboot";
in
{
  imports = [ self.nixosModules.lanzaboote ];

  boot.lanzaboote = {
    enable = true;
    configurationLimit = 5;
    privateKeyFile = "${secureboot_bundle_path}/db/db.key";
    publicKeyFile = "${secureboot_bundle_path}/db/db.crt";
  };
  boot.loader.systemd-boot.enable = lib.mkForce false;
}