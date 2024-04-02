{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.affine ];
  };
  
  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "AFFiNE")
    ];
}