{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.baidupcs-go-git ];
  };

  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "BaiduPCS-Go")
    ];
}
