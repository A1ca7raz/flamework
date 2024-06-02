{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "inkscape")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.inkscape ];
  };
}