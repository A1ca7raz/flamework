{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.nheko ];
  };

  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "nheko")
      (ls "nheko")
    ];
}
