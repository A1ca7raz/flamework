{ home, pkgs, ... }:
{
  home.packages = [ pkgs.gwenview ];

  xdg.configFile.gwenviewrc = {
    target = "gwenviewrc";
    text = ''
      [ImageView]
      AnimationMethod=DocumentView::GLAnimation
      EnlargeSmallerImages=true
      MouseWheelBehavior=MouseWheelBehavior::Zoom

      [MainWindow]
      State=AAAA/wAAAAD9AAAAAAAAAk4AAAHgAAAABAAAAAQAAAAIAAAACPwAAAABAAAAAAAAAAEAAAAWAG0AYQBpAG4AVABvAG8AbABCAGEAcgMAAAAA/////wAAAAAAAAAA

      [MainWindow][Toolbar mainToolBar]
      ToolButtonStyle=IconOnly
    '';
  };
}