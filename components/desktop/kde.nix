{ pkgs, ... }:
{
  services.xserver.desktopManager.plasma5 = {
    enable = true;
    useQtScaling = true;
    excludePackages = with pkgs; [
      oxygen
      elisa
      khelpcenter
      okular
    ];
  };

  services.xserver.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "nomad";
    sddm.enable = true;
    sddm.settings = {
      Theme = {
        Current = "breeze";
        CursorTheme = "Bibata-Modern-Ice";
        Font = "Source Han Sans SC,10,-1,5,50,0,0,0,0,0";
      };
      Users = {
        MaximumUid = 60000;
        MinimumUid = 1000;
      };
      X11 = {
        ServerArguments = "-dpi 96";
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  xdg.portal.enable = true;
}