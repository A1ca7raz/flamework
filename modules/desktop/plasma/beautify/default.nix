{ user, lib, ... }:
with lib; mkPersistDirsModule user [
  # (c "menus")
  (ls "plasma")
  (ls "kwin")
]