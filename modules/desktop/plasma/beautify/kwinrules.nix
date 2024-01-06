{ tools, user, ... }:
with tools; mkOverlayModule user {
  kwinrules = {
    target = c "kwinrulesrc";
    source = ./kwinrulesrc;
  };
}