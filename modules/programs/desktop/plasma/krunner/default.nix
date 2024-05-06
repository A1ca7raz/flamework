{ user, lib, ... }:
with lib; mkOverlayModule user {
  krunnerrc = {
    source = ./krunnerrc;
    target = c "krunnerrc";
  };
}