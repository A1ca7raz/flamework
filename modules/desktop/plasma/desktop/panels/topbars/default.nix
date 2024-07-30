{ config, lib, ... }:
with lib; let
  inherit (config.lib.appletsrc) monitorIds;
  utils = import ../_utils lib;

  applets = import ./applets.nix;
in with utils; {
  # Id=*3 for topbar
  # Id=*4 for tray

  utils.kconfig.files.plasmashellrc.items = [
    (mkItem "PlasmaTransientsConfig" "PreloadWeight" "0")
    (mkItem "Updates" "performed" "/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/containmentactions_middlebutton.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/digitalclock_migrate_font_settings.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/digitalclock_rename_timezonedisplay_key.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/folderview_fix_recursive_screenmapping.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/keyboardlayout_migrateiconsetting.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/keyboardlayout_remove_shortcut.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/klipper_clear_config.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/maintain_existing_desktop_icon_sizes.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/mediaframe_migrate_useBackground_setting.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/move_desktop_layout_config.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/no_middle_click_paste_on_panels.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/systemloadviewer_systemmonitor.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/unlock_widgets.js")
  ] ++ (mkPlasmaPanel ((elemAt monitorIds 0) + 3) 26)
    ++ (mkPlasmaPanel ((elemAt monitorIds 1) + 3) 22);

  utils.kconfig.files.appletsrc.items = with applets; (mkAppletPanel ((elemAt monitorIds 0) + 3) 1 3 [
    windowButtons
    windowTitle
    windowAppMenu
    panelSpacer
    digitalClock # inlineClock # eventCalendar
    panelSpacer
    systemTray
    # virtualDesktopBar1080
    # latteSeparator
    lockLogout
    # latteSpacer
  ]) ++ (mkAppletPanel ((elemAt monitorIds 1) + 3) 2 3 [
    windowButtons
    windowTitle
    windowAppMenu
    panelSpacer
    digitalClock # inlineClock # eventCalendar
    panelSpacer
    systemTray
    # virtualDesktopBar1080
    # latteSeparator
    lockLogout
    # latteSpacer
  ]);
}
