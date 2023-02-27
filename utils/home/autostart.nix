{ config, options, util, lib, path, ... }:
with lib; let
  cfg = config.utils.startup;

  mkStartup = name: command: {
    target = "autostart/${name}.desktop";
    text = ''
      [Desktop Entry]
      Name=${name}
      Exec=${command}"
      Type=Application
      X-KDE-autostart-after=panel
    '';
  };
in
{
  options.utils.startup = mkOption {
    type = with types; nullOr (attrsOf (str));
    default = null;
    description = "XDG Startup Applications";
  };

  config.xdg.configFile = mkIf (!isNull cfg)
    (lib.mapAttrs' (n: v: lib.attrsets.nameValuePair ("autostart_" + n) (mkStartup n v)) cfg);
}