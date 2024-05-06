{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.element-desktop ];
  };

  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "Element")
    ];
}
