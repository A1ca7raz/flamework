{
  nixosModule = { user, util, ... }:
  with util; {
    environment.overlay.users.${user} = {
      klaunchrc = {
        target = c "klaunchrc";
        text = ''
          [BusyCursorSettings]
          Bouncing=false
        '';
      };

      klipperrc = {
        target = c "klipperrc";
        text = ''
          [General]
          IgnoreImages=false
          MaxClipItems=50
        '';
      };
    };
  };

  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      kcolorchooser
      kdeconnect
      krita
    ];
  };
}