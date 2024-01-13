{ path, ... }:
{
  security.pki.certificates = [
    (builtins.readFile /${path}/config/root-r1.crt)
  ];
}