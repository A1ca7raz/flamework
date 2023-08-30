{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.telegram-desktop ];
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (ls "TelegramDesktop")
    ];
}