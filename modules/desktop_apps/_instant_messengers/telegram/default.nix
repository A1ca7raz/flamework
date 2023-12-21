{
  homeModule = { pkgs, ... }: {
    home.packages = [
#       pkgs.telegram-desktop
      pkgs."64gram"
    ];
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (ls "TelegramDesktop")
    ];
}
