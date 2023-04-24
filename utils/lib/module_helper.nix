{ lib, ... }:
{
  mkPersistDirsModule = user: dirs: {
    environment.persistence."/nix/persist".users.${user}.directories = dirs;
  };

  mkPersistFilesModule = user: files: {
    environment.persistence."/nix/persist".users.${user}.files = files;
  };
}