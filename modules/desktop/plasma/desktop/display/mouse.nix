{ lib, ... }:
with lib; let
  btn = x: mkItem ["ActionPlugins" "0"] "${x}Button;NoModifier";
  btn_ = x: mkItem ["ActionPlugins" "0" "${x}Button;NoModifier"];
  btnR = btn_ "Right";
in {
  utils.kconfig.files.appletsrc.items = [
    # Common
    (btn "Back" "org.kde.switchdesktop")
    (btn "Forward" "switchwindow")
    (btn "Middle" "org.kde.applauncher")
    (btn "Right" "org.kde.contextmenu")

    # Other Buttons
    (btn_ "Back" "showAppsByName" "true")
    (btn_ "Forward" "mode" "2")
    (btn_ "Middle" "showAppsByName" "false")

    # Right Button
    (btnR "_add panel" "false")
    (btnR "_context" "true")
    (btnR "_display_settings" "true")
    (btnR "_lock_screen" "true")
    (btnR "_logout" "true")
    (btnR "_open_terminal" "true")
    (btnR "_run_command" "false")
    (btnR "_sep1" "true")
    (btnR "_sep2" "true")
    (btnR "_sep3" "false")
    (btnR "_wallpaper" "true")
    (btnR "add widgets" "false")
    (btnR "configure" "true")
    (btnR "configure shortcuts" "false")
    (btnR "edit mode" "true")
    (btnR "manage activities" "false")
    (btnR "remove" "true")
    (btnR "run associated application" "false")

    (mkItem ["ActionPlugins" "1"] "RightButton;NoModifier" "org.kde.contextmenu")
  ];
}
