{ tools, config, lib, ... }:
with tools; let
  inherit (config.lib.appletsrc) monitorIds;

  use = id: plugin: [(mkItem ["Containments" (builtins.toString id)] "wallpaperplugin" plugin)];
  useImage = id: (use id "org.kde.image") ++ [];
  usePotd = id: (use id "org.kde.potd") ++ [
    (mkItem ["Containments" (builtins.toString id) "Wallpaper" "org.kde.potd" "General"] "FillMode" "2")
    (mkItem ["Containments" (builtins.toString id) "Wallpaper" "org.kde.potd" "General"] "Provider" "wcpotd")
  ];
in {
  utils.kconfig.files.appletsrc.items = (useImage (lib.elemAt monitorIds 0))
    ++ (useImage (lib.elemAt monitorIds 1));
}