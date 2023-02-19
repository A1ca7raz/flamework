{ pkgs, util, lib, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-gtk
      fcitx5-lua
      libsForQt5.fcitx5-qt
      # fcitx5-pinyin-zhwiki
    ];
  };

  systemd.user.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    INPUT_METHOD = "fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  systemd.user.services.fcitx5-daemon.Install.WantedBy = lib.mkForce [];

  imports = util.importsFiles ./fcitx5-conf;
}