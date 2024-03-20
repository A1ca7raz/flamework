{
  nixosModule = { user, tools, pkgs, ... }:
    with tools; let
      s = x: ./fcitx5_config/${x};
      t = x: ".config/fcitx5/" + x;
      mkst = x: {
        source = s x;
        target = t x;
      };
    in {
      i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-chinese-addons
          fcitx5-gtk
          fcitx5-lua
          kdePackages.fcitx5-qt
          fcitx5-pinyin-zhwiki
          fcitx5-pinyin-moegirl
        ];
        fcitx5.plasma6Support = true;
      };

      environment.persistence = mkPersistDirsTree user [
        (ls "fcitx5")
      ];

      environment.overlay.users.${user} = {
        fcitx5_confs = mkst "conf";

        fcitx5_config = mkst "config";

        fcitx5_profile = mkst "profile";
      };
    };

  homeModule = { ... }: {
    systemd.user.services."app-org.fcitx.Fcitx5@autostart".Install = {
      PartOf = "";
      After = "";
    };
  };
}