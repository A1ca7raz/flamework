{
  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "vlc")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.vlc ];
  };
}