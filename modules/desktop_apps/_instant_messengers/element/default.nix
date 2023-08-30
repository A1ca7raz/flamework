{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.element-desktop ];
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (c "Element")
    ];
}