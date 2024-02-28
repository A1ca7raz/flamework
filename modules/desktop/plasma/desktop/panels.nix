{ tools, config, lib, ... }:
with tools; let
  inherit (config.lib.appletsrc) monitorIds;
  presets = import ./applets.nix;
  tray = import ./tray.nix;

  mkPlasmaPanel = id: thickness: [
    (mkItem ["PlasmaViews" "Panel ${toString id}"] "alignment" "132")
    (mkItem ["PlasmaViews" "Panel ${toString id}"] "floating" "1")
    (mkItem ["PlasmaViews" "Panel ${toString id}"] "panelOpacity" "2")
    (mkItem ["PlasmaViews" "Panel ${toString id}" "Defaults"] "thickness" "${toString thickness}")
  ];

  calcAppletId = id: num: builtins.toString (id * 10 - 30 + num);
  calcTrayId = id: builtins.toString (id + 1);
  
  mkPanelItems = id: groups:
    lib.mapAttrsToList (n: v:
      mkItem (["Containments" (builtins.toString id)] ++ groups) n v
    );
  mkAppletItems = id: appId: groups: mkPanelItems id (["Applets" (calcAppletId id appId)] ++ groups);

  mkAppletPanel = id: screenId: apps:
    let
      trayId = calcTrayId id;

      conf = ["Configuration"];
      confG = conf ++ ["General"];
      confP = conf ++ ["Preferences"];
      confA = conf ++ ["Appearance"];

      mkApplets = apps: with lib;
        let
          appIds = forEach (range 1 (count (x: true) apps)) (calcAppletId id);
        in (flatten (imap1 (i: v:
          (mkAppletItems id i [] v._) ++
          (if v ? conf then
            # NOTE: SystemTray needs trayId
            if builtins.isFunction v.conf
            then (mkAppletItems id i conf (v.conf trayId))
            else (mkAppletItems id i conf v.conf)
          else []) ++
          (if v ? confG then (mkAppletItems id i confG v.confG) else []) ++
          (if v ? confP then (mkAppletItems id i confP v.confP) else []) ++
          (if v ? confA then (mkAppletItems id i confA v.confA) else [])
        ) apps)) ++
        (mkPanelItems id ["General"] {
          AppletOrder = concatStringsSep ";" appIds;
        });
    in [
      (mkItem ["Containments" (builtins.toString id)] "formfactor" "2")
      (mkItem ["Containments" (builtins.toString id)] "immutability" "1")
      (mkItem ["Containments" (builtins.toString id)] "lastScreen" (builtins.toString screenId))
      (mkItem ["Containments" (builtins.toString id)] "location" "3")
      (mkItem ["Containments" (builtins.toString id)] "plugin" "org.kde.panel")
    ] ++
    (mkApplets apps) ++
    (mkPanelItems trayId [] (tray.meta (builtins.toString screenId))) ++
    (mkPanelItems trayId ["General"] tray.g);
in {
  utils.kconfig.files.plasmashellrc.items = [
    (mkItem "PlasmaTransientsConfig" "PreloadWeight" "0")
    (mkItem "Updates" "performed" "/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/containmentactions_middlebutton.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/digitalclock_migrate_font_settings.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/digitalclock_rename_timezonedisplay_key.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/folderview_fix_recursive_screenmapping.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/keyboardlayout_migrateiconsetting.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/keyboardlayout_remove_shortcut.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/klipper_clear_config.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/maintain_existing_desktop_icon_sizes.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/mediaframe_migrate_useBackground_setting.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/move_desktop_layout_config.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/no_middle_click_paste_on_panels.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/systemloadviewer_systemmonitor.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/unlock_widgets.js")
  ] ++ (mkPlasmaPanel ((lib.elemAt monitorIds 0) + 2) 26)
    ++ (mkPlasmaPanel ((lib.elemAt monitorIds 1) + 2) 22);

  utils.kconfig.files.appletsrc.items = with presets; (mkAppletPanel ((lib.elemAt monitorIds 0) + 2) 1 [
    windowButtons
    windowTitle
    windowAppMenu
    panelSpacer
    inlineClock # eventCalendar
    panelSpacer
    systemTray
    virtualDesktopBar1080
    separator
    lockLogout
    latteSpacer
  ]) ++ (mkAppletPanel ((lib.elemAt monitorIds 1) + 2) 2 [
    windowButtons
    windowTitle
    windowAppMenu
    panelSpacer
    inlineClock # eventCalendar
    panelSpacer
    systemTray
    virtualDesktopBar1440
    separator
    lockLogout
    latteSpacer
  ]);
}