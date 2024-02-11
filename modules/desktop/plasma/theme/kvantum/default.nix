{
  nixosModule = { config, user, tools, ... }:
    let
      inherit (config.lib.theme) KvantumTheme;
    in {
      utils.kconfig.rules = [
        { f = "kvconfig"; g = "General"; k = "theme"; v = KvantumTheme; }

        # Application Style
        { f = "kdeglobals"; g = "KDE"; k = "widgetStyle"; v = "kvantum"; }
      ];

      # Persistence
      environment.persistence = with tools; mkPersistDirsModule user [
        (c "Kvantum")
      ];
    };
  
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.libsForQt5.qtstyleplugin-kvantum ];
  };
}