{ home, pkgs, ... }:
{
  home.packages = [
    (pkgs.ark.override { unfreeEnableUnrar = true; })
  ];

  xdg.configFile.arkrc = {
    target = "arkrc";
    text = ''
      [General]
      defaultOpenAction=Open

      [MainWindow]
      State=AAAA/wAAAAD9AAAAAAAAAn4AAAH0AAAABAAAAAQAAAAIAAAACPwAAAABAAAAAQAAAAEAAAAWAG0AYQBpAG4AVABvAG8AbABCAGEAcgMAAAAA/////wAAAAAAAAAA

      [MainWindow][Toolbar mainToolBar]
      ToolButtonStyle=IconOnly
    '';
  };
}