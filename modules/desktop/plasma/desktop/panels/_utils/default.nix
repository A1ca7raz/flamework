lib:
with lib; let
  tray = import ./tray.nix;
in rec {
  mkPlasmaPanel = id: thickness: [
    (mkItem ["PlasmaViews" "Panel ${toString id}"] "alignment" "132")
    (mkItem ["PlasmaViews" "Panel ${toString id}"] "floating" "1")
    (mkItem ["PlasmaViews" "Panel ${toString id}"] "panelOpacity" "2")
    (mkItem ["PlasmaViews" "Panel ${toString id}" "Defaults"] "thickness" "${toString thickness}")
  ];

  mkPanelItems = id: groups:
    mapAttrsToList (n: v:
      mkItem (["Containments" (builtins.toString id)] ++ groups) n v
    );

  # calcAppletId = id: num: builtins.toString (id / 10 * 10 + num);
  calcAppletId = id: appId:
    let
      base = (id + 5) / 10 * 10;
    in builtins.toString (
      if base > id
      then base * 10 + appId + 100
      else base * 10 + appId
    );


  mkAppletItems = id: appId: groups: mkPanelItems id (["Applets" (calcAppletId id appId)] ++ groups);

  mkAppletPanel = id: screenId: location: apps:
    let
      trayId = builtins.toString (id + 1);

      conf = ["Configuration"];
      confG = conf ++ ["General"];
      confP = conf ++ ["Preferences"];
      confA = conf ++ ["Appearance"];

      mkApplets = apps:
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
      (mkItem ["Containments" (builtins.toString id)] "location" (builtins.toString location))
      (mkItem ["Containments" (builtins.toString id)] "plugin" "org.kde.panel")
    ] ++
    (mkApplets apps) ++
    (mkPanelItems trayId [] (tray.meta (builtins.toString screenId))) ++
    (mkPanelItems trayId ["General"] tray.g);
}
