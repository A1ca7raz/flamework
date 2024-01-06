{
  homeModule = { pkgs, ... }: {
    home.packages = [
      pkgs.telegram-desktop
#       pkgs."64gram"
    ];
  };

  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (ls "TelegramDesktop")
    ];
}
