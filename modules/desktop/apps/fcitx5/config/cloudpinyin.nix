{ ... }:
{
  xdg.configFile.fcitx5_conf_cloudpinyin = {
    target = "fcitx5/conf/cloudpinyin.conf";
    text = ''
      # 最小拼音长度
      MinimumPinyinLength=2
      # 后端
      Backend=Baidu
      # 代理
      Proxy=

      [Toggle Key]
      0=Control+Alt+Shift+C
    '';
  };
}