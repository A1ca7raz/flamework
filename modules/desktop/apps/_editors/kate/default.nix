{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.kate ];
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (ls "kate")
    ];
}