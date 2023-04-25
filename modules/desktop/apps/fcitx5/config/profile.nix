{ ... }:
{
  xdg.configFile.fcitx5_profile = {
    target = "fcitx5/profile";
    text = ''
      [Groups/0]
      # Group Name
      Name=默认
      # Layout
      Default Layout=us
      # Default Input Method
      DefaultIM=pinyin

      [Groups/0/Items/0]
      # Name
      Name=keyboard-us
      # Layout
      Layout=

      [Groups/0/Items/1]
      # Name
      Name=pinyin
      # Layout
      Layout=

      [Groups/0/Items/2]
      # Name
      Name=shuangpin
      # Layout
      Layout=

      [GroupOrder]
      0=默认
    '';
  };
}