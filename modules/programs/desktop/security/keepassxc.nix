{
  nixosModule = { user, lib, ... }:
    with lib; mkOverlayModule user {
      keepassxc_ini = {
        target = c "keepassxc/keepassxc.ini";
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
    };

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.keepassxc ];
  };
}