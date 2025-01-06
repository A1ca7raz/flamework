{ self, ... }:
{
  nixpkgs.overlays = [
    self.overlays.pkgs
  ];
}