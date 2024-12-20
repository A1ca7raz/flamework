{
  nixosModule = { config, user, lib, ... }:
    with lib; let
      inherit (config.lib.theme) KvantumTheme;
    in {
      utils.kconfig.rules = [
        { f = "kvconfig"; g = "General"; k = "theme"; v = KvantumTheme; }

        # Application Style
        { f = "kdeglobals"; g = "KDE"; k = "widgetStyle"; v = "kvantum"; }
      ];

      # Persistence
      environment.persistence = mkPersistDirsTree user [
        (c "Kvantum")
      ];
      environment.overlay = mkOverlayTree user {
        kvconfig = {
          source = config.utils.kconfig.files.kvconfig.path;
          target = c "Kvantum/kvantum.kvconfig";
        };
      };
    };
  
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum  # For Qt5 Applications
    ];
  };
}
