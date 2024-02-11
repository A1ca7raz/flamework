{ config, tools, lib, ... }:
let
  inherit (config.lib.plasma) activityId;
  mkItem = x: if builtins.isList x
   then tools.mkItem (["Containments"] ++ x)
   else tools.mkItem (["Containments" (builtins.toString x)]);
  mkMonitorBasic = id: [
    (mkItem id "activityId" activityId)
    (mkItem id "formfactor" "0")
    (mkItem id "immutability" "1")
    (mkItem id "lastScreen" (builtins.toString ((id / 10))))
    (mkItem id "location" "0")
    (mkItem id "immutability" "1")
    (mkItem id "plugin" "org.kde.desktopcontainment")
    (mkItem (id + 1) "activityId" activityId)
    (mkItem (id + 1) "formfactor" "0")
    (mkItem (id + 1) "immutability" "1")
    (mkItem (id + 1) "lastScreen" (builtins.toString ((id / 10) + 2)))
    (mkItem (id + 1) "location" "0")
    (mkItem (id + 1) "immutability" "1")
    (mkItem (id + 1) "plugin" "org.kde.plasma.folder")
  ];
in {
  lib.appletsrc.monitorIds = [ 11 21 ];

  utils.kconfig.files.appletsrc.items = (mkMonitorBasic (lib.elemAt config.lib.appletsrc.monitorIds 0))
    ++ (mkMonitorBasic (lib.elemAt config.lib.appletsrc.monitorIds 1));
}