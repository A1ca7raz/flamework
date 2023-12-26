{
  nixosModule = { user, tools, ... }:
    with tools; mkPersistFilesModule user [
      (c "kshisenrc")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.libsForQt5.kshisen ];
  };
}