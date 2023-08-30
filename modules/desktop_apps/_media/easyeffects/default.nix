{
  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (c "easyeffects")
    ];

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.easyeffects ];
  };
}