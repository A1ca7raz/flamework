{
  homeModule = { pkgs, ... }: {
    home.packages = [
      pkgs.telegram-desktop
#       pkgs."64gram"
    ];
  };

  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (ls "TelegramDesktop")
    ];
}
