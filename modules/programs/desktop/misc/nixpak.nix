{ user, lib, ... }:
with lib; mkPersistDirsModule user [
  ".local/state/nixpak"
]
