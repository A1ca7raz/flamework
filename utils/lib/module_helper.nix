{ lib, ... }:
rec {
  mkPersistDirsTree = user: dirs: {
    "/nix/persist".users.${user}.directories = dirs;
  };

  mkPersistDirsModule = user: dirs: {
    environment.persistence = mkPersistDirsTree user dirs;
  };

  mkPersistFilesModule = user: files: {
    environment.persistence."/nix/persist".users.${user}.files = files;
  };


  mkOverlayTree = user: sets: {
    users.${user} = sets;
  };

  mkOverlayModule = user: sets: {
    environment.overlay = mkOverlayTree user sets;
  };

  mkHomePackagesTree = list: {
    packages = list;
  };

  mkHomePackagesModule = list: {
    home = mkHomePackagesTree list;
  };
}