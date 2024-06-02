{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "maa")
    ];
  
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.maa-cli ];
  };
}