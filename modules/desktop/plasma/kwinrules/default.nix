{ lib, user, ... }:
with lib; mkOverlayModule user {
  kwinrules = {
    target = c "kwinrulesrc";
    source = ./kwinrulesrc;
  };
}