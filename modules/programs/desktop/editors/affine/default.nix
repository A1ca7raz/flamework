{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.affine ];
  };
  
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "AFFiNE")
    ];
}