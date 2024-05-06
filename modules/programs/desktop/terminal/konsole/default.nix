{ user, lib, ... }:
with lib; mkOverlayModule user {
  konsolerc = {
    source = ./konsolerc;
    target = c "konsolerc";
  };

  konsole_notifyrc = {
    source = ./konsole.notifyrc;
    target = c "konsole.notifyrc";
  };

  konsole_gui = {
    source = ./konsole_gui;
    target = ls "kxmlgui5/konsole/partui.rc";
  };
}