{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "vlc")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.vlc ];
  };
}