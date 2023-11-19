{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.schildichat-desktop ];
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
#       (c "Element")
      (c "SchildiChat")
    ];
}
