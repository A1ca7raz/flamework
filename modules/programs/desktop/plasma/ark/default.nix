{
  nixosModule = { tools, user, ... }:
    with tools; {
      environment.overlay.users.${user}.arkrc = {
        target = c "arkrc";
        text = ''
          [General]
          defaultOpenAction=Open

          [MainWindow]
          State=AAAA/wAAAAD9AAAAAAAAAn4AAAH0AAAABAAAAAQAAAAIAAAACPwAAAABAAAAAQAAAAEAAAAWAG0AYQBpAG4AVABvAG8AbABCAGEAcgMAAAAA/////wAAAAAAAAAA

          [MainWindow][Toolbar mainToolBar]
          ToolButtonStyle=IconOnly
        '';
      };
    };

  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      ark-unrar
      unzip-nls
      p7zip
    ];
  };
}