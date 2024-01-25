{ ... }:
{
  imports = [
    ./kes.nix

    # NOTE: The minio module in nixpkgs is sh*t.
    ./minio.nix
    ./proxy.nix
  ];
}