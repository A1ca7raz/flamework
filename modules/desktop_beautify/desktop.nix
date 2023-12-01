{ util, user, ... }:
with util; mkOverlayModule user {
  desktop-appletsrc = {
    source = ./plasma-org.kde.plasma.desktop-appletsrc;
    target = c "plasma-org.kde.plasma.desktop-appletsrc";
  };

  plasmashellrc = {
    text = ''
      [PlasmaTransientsConfig]
      PreloadWeight=0

      [PlasmaViews][Panel 28]
      alignment=132
      floating=1
      panelOpacity=2

      [PlasmaViews][Panel 28][Defaults]
      thickness=22

      [PlasmaViews][Panel 80]
      alignment=132
      floating=1
      panelOpacity=2

      [PlasmaViews][Panel 80][Defaults]
      thickness=26

      [Updates]
      performed=/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/containmentactions_middlebutton.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/digitalclock_migrate_font_settings.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/digitalclock_rename_timezonedisplay_key.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/folderview_fix_recursive_screenmapping.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/keyboardlayout_migrateiconsetting.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/keyboardlayout_remove_shortcut.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/klipper_clear_config.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/maintain_existing_desktop_icon_sizes.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/mediaframe_migrate_useBackground_setting.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/move_desktop_layout_config.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/no_middle_click_paste_on_panels.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/systemloadviewer_systemmonitor.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/unlock_widgets.js
    '';
    target = c "plasmashellrc";
  };
}

# { home, util, lib, path, pkgs, ... }:
# let
#   _wc = util.wrapWC pkgs;
#   _wc_ = util.wrapWC_ pkgs;
#   wc = _wc "plasma-org.kde.plasma.desktop-appletsrc";
#   wcl = _wc_ "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc";
#   wcr = wcl ["ActionPlugins" "0" "RightButton;NoModifier"];

#   wcd = wcl ["Containments" "25"];
#   wcwp = wcl ["Containments" "25" "Wallpaper" "org.kde.potd" "General"];
#   wcwh = wcl ["Containments" "25" "Wallpaper" "net.sub-pop.kdewallhavenwallpaper" "General"];


#   activityId = import /${path}/config/activity-id.nix;
# in {
#   home.activation.setupDesktop = lib.hm.dag.entryAfter ["writeBoundary"] ''
#     # Mouse Action
#     ${wcl ["ActionPlugins" "0"] "BackButton;NoModifier" "org.kde.switchdesktop"}
#     ${wcl ["ActionPlugins" "0"] "ForwardButton;NoModifier" "switchwindow"}
#     ${wcl ["ActionPlugins" "0"] "MiddleButton;NoModifier" "org.kde.applauncher"}
#     ${wcl ["ActionPlugins" "0"] "RightButton;NoModifier" "org.kde.contextmenu"}
#     ${wcl ["ActionPlugins" "0" "BackButton;NoModifier"] "showAppsByName" "true"}
#     ${wcl ["ActionPlugins" "0" "ForwardButton;NoModifier"] "mode" "2"}
#     ${wcl ["ActionPlugins" "1"] "RightButton;NoModifier" "org.kde.contextmenu"}

#     # Right Button Menu
#     ${wcr "_add panel" "false"}
#     ${wcr "_context" "true"}
#     ${wcr "_display_settings" "true"}
#     ${wcr "_lock_screen" "true"}
#     ${wcr "_logout" "true"}
#     ${wcr "_open_terminal" "true"}
#     ${wcr "_run_command" "false"}
#     ${wcr "_sep1" "true"}
#     ${wcr "_sep2" "true"}
#     ${wcr "_sep3" "false"}
#     ${wcr "_wallpaper" "true"}
#     ${wcr "add widgets" "false"}
#     ${wcr "configure" "true"}
#     ${wcr "configure shortcuts" "false"}
#     ${wcr "edit mode" "true"}
#     ${wcr "manage activities" "false"}
#     ${wcr "remove" "true"}
#     ${wcr "run associated application" "false"}

#     # Desktop Configuration
#     ${wcd "activityId" activityId}
#     ${wcd "location" "0"}
#     ${wcd "immutability" "1"}
#     ${wcd "formfactor" "0"}
#     ${wcd "plugin" "org.kde.desktopcontainment"}
#     ${wcd "wallpaperplugin" "org.kde.image"}

#     # Wallpaper Plugin
#     ${wcwp "FillMode" "2"}
#     ${wcwp "Provider" "wcpotd"}
#     ${wcwh "FillMode" "2"}
#     ${wcwh "Sorting" "random"}

#     # Latte Hold Meta Launch
#     ${_wc "kwinrc" "ModifierOnlyShortcuts" "Meta" "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu"}
#   '';
# }
