{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.logseq ];
  };

  nixosModule = { user, lib, ... }: {
    environment.persistence = with lib; mkPersistDirsTree user [
      (c "Logseq") ".logseq"
    ];
    nixpkgs.config.permittedInsecurePackages = [
      "electron-27.3.11"
    ];
  };
}
