{ home, pkgs, ... }:
{
  home.packages = with pkgs; [
    kcolorchooser
    kdeconnect
    krita
  ];

  xdg.configFile = {
    klaunchrc = {
      target = "klaunchrc";
      text = ''
        [BusyCursorSettings]
        Bouncing=false
      '';
    };

    klipperrc = {
      target = "klipperrc";
      text = ''
        [General]
        IgnoreImages=false
        MaxClipItems=50
      '';
    };
  };
}