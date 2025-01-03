{ config, lib, ... }:
with lib; let
  inherit (config.lib.appletsrc) monitorIds;

  use = id: plugin: [(mkItem ["Containments" (builtins.toString id)] "wallpaperplugin" plugin)];

  selectMonitor = index: offset: (elemAt monitorIds index) + offset;

  useImage = id: (use id "org.kde.image") ++ [
    (mkItem ["Containments" (builtins.toString id) "Wallpaper" "org.kde.image" "General"] "Image" "/run/current-system/sw/share/wallpapers/Next/")
  ];

  usePotd = id: (use id "org.kde.potd") ++ [
    (mkItem ["Containments" (builtins.toString id) "Wallpaper" "org.kde.potd" "General"] "FillMode" "2")
    (mkItem ["Containments" (builtins.toString id) "Wallpaper" "org.kde.potd" "General"] "Provider" "bing")
  ];
in {
  utils.kconfig.files.appletsrc.items = (usePotd (selectMonitor 0 1))
    ++ (useImage (selectMonitor 1 1));
}
