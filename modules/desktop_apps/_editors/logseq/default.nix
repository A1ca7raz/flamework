{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.logseq ];
  };

  nixosModule = { user, tools, ... }: {
    environment.persistence = with tools; mkPersistDirsTree user [
      (c "Logseq") ".logseq"
    ];
    nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };
}
