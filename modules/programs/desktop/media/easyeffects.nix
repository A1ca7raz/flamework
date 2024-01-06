{
  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "easyeffects")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.easyeffects ];
  };
}