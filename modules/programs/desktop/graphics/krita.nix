{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (ls "krita")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.krita ];
  };
}