{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "maa")
      (ls "maa")
    ];
  
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.maa-cli-fix ];
  };
}
