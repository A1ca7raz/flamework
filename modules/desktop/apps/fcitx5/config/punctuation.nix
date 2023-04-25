{ ... }:
{
  xdg.configFile.fcitx5_conf_punctuation = {
    target = "fcitx5/conf/punctuation.conf";
    text = ''
      # 字母或者数字之后输入半角标点
      HalfWidthPuncAfterLetterOrNumber=True
      # 同时输入成对标点 (例如引号)
      TypePairedPunctuationsTogether=True
      # Enabled
      Enabled=True

      [Hotkey]
      0=Control+period
    '';
  };
}