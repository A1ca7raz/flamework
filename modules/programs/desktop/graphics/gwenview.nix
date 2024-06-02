{
  nixosModule = { lib, user, ... }:
    with lib; {
      environment.overlay.users.${user}.gwenviewrc = {
        target = c "gwenviewrc";
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
    };

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.kdePackages.gwenview ];
  };
}