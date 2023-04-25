{
  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (c "vlc")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.vlc ];
  };
}