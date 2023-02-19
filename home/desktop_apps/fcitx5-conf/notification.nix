{ ... }:
{
  xdg.configFile.fcitx5_conf_notification = {
    target = "fcitx5/conf/notification.conf";
    text = ''
      [HiddenNotifications]
      0=fcitx-punc-toggle
    '';
  };
}