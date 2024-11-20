{ inputs, ... }:
{
  nixpkgs.overlays = [
    (f: p: {
      nixpaks = inputs.nur.packageBundles.x86_64-linux.nixpakPackages;
    })
  ];
}
