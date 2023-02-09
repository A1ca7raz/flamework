{ lib, ... }:
{
  sops.age.keyFile = lib.mkIf (builtins.pathExists /var/lib/age.key) "/var/lib/age.key";
}