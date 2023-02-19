{ ... }:
{
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