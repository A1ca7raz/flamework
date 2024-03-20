{
  nixosModule = { tools, config, user, ... }:
    with tools; let
      inherit (config.lib) themeColor;
      inherit (config.lib.theme) ThemeColor;

      kwinrc = mkRule "kwinrc";
    in {
      imports = [ ./config.nix ];

      environment.overlay = mkOverlayTree user {
        sierrabreezeenhancedrc = {
          target = c "sierrabreezeenhancedrc";
          source = config.utils.kconfig.files.sierrabreezeenhancedrc.path;
        };
      };

      utils.kconfig.rules = [
        # Window decorations
        (kwinrc "org.kde.kdecoration2" "theme" "Sierra Breeze Enhanced")
        (kwinrc "org.kde.kdecoration2" "library" "sierrabreezeenhanced")

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
    home.packages = with pkgs; [
      sierra-breeze-enhanced-kde6
      breeze-enhanced-kde6
    ];
  };
}