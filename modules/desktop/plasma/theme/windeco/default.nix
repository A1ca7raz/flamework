{
  nixosModule = { tools, user, config, ... }:
    with tools; let
      inherit (config.lib) themeColor;
      inherit (config.lib.theme) ThemeColor;

      kwinrc = mkRule "kwinrc";
    in {
      environment.overlay = mkOverlayTree user {
        sierrabreezeenhancedrc = {
          target = c "sierrabreezeenhancedrc";
          source = ./sierrabreezeenhancedrc;
        };
      };

      utils.kconfig.rules = [
        # Window decorations
        (kwinrc "org.kde.kdecoration2" "theme" "Sierra Breeze Enhanced")
        (kwinrc "org.kde.kdecoration2" "library" "org.kde.sierrabreezeenhanced")

        ## Titlebar Transparency
        (mkRule "sierrabreezeenhancedrc" "Windeco" "BackgroundOpacity" (
          if (ThemeColor == "Dark")
          then themeColor.dark.windecoOpacity
          else if (ThemeColor == "Light")
          then themeColor.light.windecoOpacity
          else "100"
        ))

        ## Window Border
        (kwinrc "org.kde.kdecoration2" "BorderSize" "None")
        (kwinrc "org.kde.kdecoration2" "BorderSizeAuto" "false")

        ## Titlebar Buttons
        (kwinrc "org.kde.kdecoration2" "ButtonsOnLeft" "XM")
        (kwinrc "org.kde.kdecoration2" "ButtonsOnRight" "IA")
        (kwinrc "org.kde.kdecoration2" "CloseOnDoubleClickOnMenu" "true")
      ];
    };

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.sierra-breeze-enhanced-wayland ];
  };
}