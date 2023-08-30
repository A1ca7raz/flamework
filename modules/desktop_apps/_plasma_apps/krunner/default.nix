{ user, util, ... }:
with util; mkOverlayModule user {
  krunnerrc = {
    source = ./krunnerrc;
    target = c "krunnerrc";
  };
}