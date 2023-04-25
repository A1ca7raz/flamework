{ home, pkgs, ... }:
{
  home.packages = [ pkgs.keepassxc ];
  xdg.configFile.keepassxc = {
    target = "keepassxc/keepassxc.ini";
    text = ''
      [General]
      MinimizeAfterUnlock=true
      UseAtomicSaves=false

      [Browser]
      CustomProxyLocation=
      Enabled=true

      [GUI]
      Language=zh_CN
      MinimizeOnClose=true
      MinimizeToTray=true
      ApplicationTheme=classic
      MonospaceNotes=true
      ShowTrayIcon=true
      TrayIconAppearance=monochrome-light

      [Security]
      EnableCopyOnDoubleClick=true
    '';
  };
}