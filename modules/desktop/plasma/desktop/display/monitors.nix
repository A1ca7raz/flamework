{ config, lib, user, ... }:
let
  inherit (config.lib.plasma) activityId;

  monitorCounts = 2;

  monitorIds = lib.forEach (lib.range 1 monitorCounts) (id: id * 10);

  mkItem = x: if builtins.isList x
   then lib.mkItem (["Containments"] ++ x)
   else lib.mkItem (["Containments" (builtins.toString x)]);

  mkMonitorBasic = id: [
    ## Id=*1 for desktop view
    (mkItem (id + 1) "activityId" activityId)
    (mkItem (id + 1) "formfactor" "0")
    (mkItem (id + 1) "immutability" "1")
    (mkItem (id + 1) "lastScreen" (builtins.toString ((id / 10))))
    (mkItem (id + 1) "location" "0")
    (mkItem (id + 1) "immutability" "1")
    (mkItem (id + 1) "plugin" "org.kde.desktopcontainment")

    ## Id=*2 for folder view
    (mkItem (id + 2) "activityId" activityId)
    (mkItem (id + 2) "formfactor" "0")
    (mkItem (id + 2) "immutability" "1")
    (mkItem (id + 2) "lastScreen" (builtins.toString ((id / 10) + 2)))
    (mkItem (id + 2) "location" "0")
    (mkItem (id + 2) "immutability" "1")
    (mkItem (id + 2) "plugin" "org.kde.plasma.folder")
  ];
in {
  lib.appletsrc.monitorIds = monitorIds;

  utils.kconfig.files.appletsrc.items = lib.foldr
    (id: acc: (mkMonitorBasic id) ++ acc)
    []
    monitorIds;

  environment.overlay = lib.mkOverlayTree user {
    desktop-appletsrc = {
      source = config.utils.kconfig.files.appletsrc.path;
      target = lib.c "plasma-org.kde.plasma.desktop-appletsrc";
    };
  };
}
