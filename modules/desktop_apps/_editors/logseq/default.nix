{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.logseq ];
  };

  nixosModule = { user, util, ... }: {
    environment.persistence = with util; mkPersistDirsTree user [
      (c "Logseq") ".logseq"
    ];
    nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };
}
