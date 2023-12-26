{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.wpsoffice ];
  };

  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "Kingsoft") (ls "Kingsoft")
    ];
}