{
  nixosModule = { util, user, ... }:
  with util; {
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
    home.packages = [ pkgs.ark-unrar ];
  };
}