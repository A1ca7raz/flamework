{
  nixosModule = { config, ... }:
    let
      inherit (config.lib.theme) PlasmaTheme;
    in {
      utils.kconfig.rules = [
        # Plasma Style
        { f = "plasmarc"; g = "Theme"; k = "name"; v = PlasmaTheme; }
        # Splash screen
        { f = "ksplashrc"; g = "KSplash"; k = "Theme"; v = "Arch-Splash"; }
      ];
    };

  homeModule = { pkgs, ... }: {
    # home.packages = [ pkgs.dconf ];
    home.sessionVariables.GTK_USE_PORTAL = "1";

    # qt.enable = true;
    # qt.platformTheme = "kde";
  };
}