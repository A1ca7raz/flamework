{ user, tools, ... }:
with tools; mkOverlayModule user {
  krunnerrc = {
    source = ./krunnerrc;
    target = c "krunnerrc";
  };
}