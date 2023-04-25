{
  homeModule = { util, ... }: {
    imports = util.importsFiles ./config;
  };

  nixosModule = { user, util, pkgs, ... }:
    with util; (mkPersistDirsModule user [
      (ls "fcitx5")
    ]) // {
      i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-chinese-addons
          fcitx5-gtk
          fcitx5-lua
          libsForQt5.fcitx5-qt
          fcitx5-pinyin-zhwiki
        ];
      };
    };
}
