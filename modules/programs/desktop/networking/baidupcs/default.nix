{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.baidupcs-go ];
  };

  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "BaiduPCS-Go")
    ];
}
