{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs; with kdePackages; [
    oxygen
    elisa
    khelpcenter
    okular
  ];

  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "nomad";
    sddm.enable = true;
    sddm.wayland.enable = true;
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

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };
}