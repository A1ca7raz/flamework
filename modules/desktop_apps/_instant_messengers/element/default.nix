{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.element-desktop ];
  };

  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "Element")
    ];
}
