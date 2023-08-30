{ util, user, ... }:
with util; mkOverlayModule user {
  kwinrules = {
    target = c "kwinrulesrc";
    source = ./kwinrulesrc;
  };
}