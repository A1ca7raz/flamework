{
  nixosModule = { user, util, ... }:
  with util; {
    environment.persistence = mkPersistDirsTree user [
      (c "Kvantum")
      (c "latte")
      (ls "latte")
      (c "menus")
      (ls "plasmashell")
      (ls "plasma")
      (ls "kwin")
      # (ls "icons")
      # ".icons"
    ];

    # environment.overlay = mkOverlayTree user {

    # };
    #   files = [
    #     # (c "kglobalshortcutsrc")
    #     # (c "khotkeysrc")
    #     (c "kwinrulesrc")
    #     # (c "plasma-org.kde.plasma.desktop-appletsrc")
    #   ];
  };

  homeModule = { util, ... }: {
    imports = util.importsFiles ./.;
  };
}