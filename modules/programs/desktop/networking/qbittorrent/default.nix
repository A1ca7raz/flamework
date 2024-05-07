{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "qBittorrent")
      (ls "qBittorrent")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.qbittorrent ];
  };
}