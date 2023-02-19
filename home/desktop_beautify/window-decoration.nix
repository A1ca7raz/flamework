{ pkgs, ... }:
{
  home.packages = [ pkgs.sierra-breeze-enhanced ];

  xdg.configFile.sierrabreezeenhancedrc = {
    target = "sierrabreezeenhancedrc";
    text = ''
      [Common]
      ShadowSize=ShadowSmall

      [Windeco]
      BackgroundGradientIntensity=100
      BackgroundOpacity=55
      ButtonStyle=sbeDarkAuroraeActive
      DrawBackgroundGradient=false
      DrawTitleBarSeparator=false
      MatchColorForTitleBar=true
      OpaqueTitleBar=false
      UnisonHovering=false

      [Windeco Exception 0]
      BorderSize=2
      DrawBackgroundGradient=false
      DrawTitleBarSeparator=false
      Enabled=true
      ExceptionPattern=Steam
      ExceptionType=0
      GradientOverride=-1
      HideTitleBar=3
      IsDialog=false
      Mask=0
      MatchColorForTitleBar=true
      OpacityOverride=-1
      OpaqueTitleBar=false
    '';
  };
}