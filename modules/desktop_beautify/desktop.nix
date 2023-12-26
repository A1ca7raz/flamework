{ tools, user, ... }:
with tools; mkOverlayModule user {
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