{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.telegram-archpatched ];
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (ls "TelegramDesktop")
    ];
}