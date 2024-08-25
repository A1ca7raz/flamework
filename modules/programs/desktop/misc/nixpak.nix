{ user, lib, inputs, ... }:
with lib; {
  environment.persistence = mkPersistDirsTree user [
    ".local/state/nixpak"
  ];

  nixpkgs.overlays = [
    (f: p: {
      nixpaks = inputs.nur.packageBundles.x86_64-linux.nixpakPackages;
    })
  ];
}
