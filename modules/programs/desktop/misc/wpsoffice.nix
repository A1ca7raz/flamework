{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.wpsoffice ];
  };

  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "Kingsoft") (ls "Kingsoft")
    ];
}