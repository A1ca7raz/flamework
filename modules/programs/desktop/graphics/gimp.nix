{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "GIMP")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.gimp-with-plugins ];
  };
}