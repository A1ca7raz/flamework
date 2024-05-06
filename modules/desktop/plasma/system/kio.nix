{ lib, ... }:
with lib; {
  utils.kconfig.files.kiorc.items = [
    (mkItem "Confirmations" "ConfirmDelete" "false")
    (mkItem "Confirmations" "ConfirmEmptyTrash" "false")
    (mkItem "Confirmations" "ConfirmTrash" "false")
    (mkItem "Executable scripts" "behaviourOnLaunch" "open")
  ];
}