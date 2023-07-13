{ lib, ... }:
{
  mkPersistDirsModule = user: dirs: {
    environment.persistence."/nix/persist".users.${user}.directories = dirs;
  };

  mkPersistFilesModule = user: files: {
    environment.persistence."/nix/persist".users.${user}.files = files;
  };

  mkPersistDirsTree = user: dirs: {
    "/nix/persist".users.${user}.directories = dirs;
  };

  mkOverlayModule = user: sets: {
    environment.overlay.users.${user} = sets;
  };

  mkOverlayTree = user: sets: {
    users.${user} = sets;
  };
}