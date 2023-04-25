{
  nixosModule = { user, util, ... }:
    with util; mkPersistFilesModule user [
      (c "kshisenrc")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.libsForQt5.kshisen ];
  };
}