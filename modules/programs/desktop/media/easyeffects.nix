{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "easyeffects")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.easyeffects ];
  };
}