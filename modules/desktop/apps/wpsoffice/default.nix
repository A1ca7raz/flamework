{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.wpsoffice ];
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (c "kingsoft") (ls "Kingsoft")
    ];
}