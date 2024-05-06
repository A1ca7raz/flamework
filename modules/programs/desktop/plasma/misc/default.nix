{
  nixosModule = { user, lib, ... }:
    with lib; {
      environment.overlay = mkOverlayTree user {
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

      environment.persistence = mkPersistDirsTree user [
        # Plasma APPs
        (c "kdeconnect")
        (ls "krita")

        # System
        (ls "kactivitymanagerd")
        (ls "kcookiejar")
        (ls "kded5")
        (ls "keyrings")
        (ls "klipper")
        (ls "kscreen")
        (ls "kwalletd")
        (c "plasma-nm")
      ];
    };

  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; with kdePackages; [
      kcolorchooser
      kdeconnect-kde
      krita
    ];
  };
}