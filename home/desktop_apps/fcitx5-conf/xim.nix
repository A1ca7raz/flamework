{ ... }:
{
  xdg.configFile.fcitx5_conf_xim = {
    target = "fcitx5/conf/xim.conf";
    text = ''
      # 使用 On The Spot 风格 (需要重启)
      UseOnTheSpot=True
    '';
  };
}