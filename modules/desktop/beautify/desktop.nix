{ home, util, lib, path, pkgs, ... }:
let
  _wc = util.wrapWC pkgs;
  _wc_ = util.wrapWC_ pkgs;
  wc = _wc "plasma-org.kde.plasma.desktop-appletsrc";
  wcl = _wc_ "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc";
  wcr = wcl ["ActionPlugins" "0" "RightButton;NoModifier"];

  wcd = wcl ["Containments" "25"];
  wcwp = wcl ["Containments" "25" "Wallpaper" "org.kde.potd" "General"];

  activityId = import /${path}/config/activity-id.nix;
in {
  home.activation.setupDesktop = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Mouse Action
    ${wcl ["ActionPlugins" "0"] "BackButton;NoModifier" "org.kde.switchdesktop"}
    ${wcl ["ActionPlugins" "0"] "ForwardButton;NoModifier" "switchwindow"}
    ${wcl ["ActionPlugins" "0"] "MiddleButton;NoModifier" "org.kde.applauncher"}
    ${wcl ["ActionPlugins" "0"] "RightButton;NoModifier" "org.kde.contextmenu"}
    ${wcl ["ActionPlugins" "0" "BackButton;NoModifier"] "showAppsByName" "true"}
    ${wcl ["ActionPlugins" "0" "ForwardButton;NoModifier"] "mode" "2"}
    ${wcl ["ActionPlugins" "1"] "RightButton;NoModifier" "org.kde.contextmenu"}

    # Right Button Menu
    ${wcr "_add panel" "false"}
    ${wcr "_context" "true"}
    ${wcr "_display_settings" "true"}
    ${wcr "_lock_screen" "true"}
    ${wcr "_logout" "true"}
    ${wcr "_open_terminal" "true"}
    ${wcr "_run_command" "false"}
    ${wcr "_sep1" "true"}
    ${wcr "_sep2" "true"}
    ${wcr "_sep3" "false"}
    ${wcr "_wallpaper" "true"}
    ${wcr "add widgets" "false"}
    ${wcr "configure" "true"}
    ${wcr "configure shortcuts" "false"}
    ${wcr "edit mode" "true"}
    ${wcr "manage activities" "false"}
    ${wcr "remove" "true"}
    ${wcr "run associated application" "false"}

    # Desktop Configuration
    ${wcd "activityId" activityId}
    ${wcd "location" "0"}
    ${wcd "immutability" "1"}
    ${wcd "formfactor" "0"}
    ${wcd "plugin" "org.kde.desktopcontainment"}
    ${wcd "wallpaperplugin" "org.kde.potd"}

    # Wallpaper Plugin
    ${wcwp "FillMode" "2"}
    ${wcwp "Provider" "wcpotd"}

    # Latte Hold Meta Launch
    ${_wc "kwinrc" "ModifierOnlyShortcuts" "Meta" "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu"}
  '';
}