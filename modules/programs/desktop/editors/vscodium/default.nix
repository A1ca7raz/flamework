{
  homeModule = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium.override {
        commandLineArgs = "--extensions-dir ~/.local/share/VSCodium/extensions";
      };
    };
  };


  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "VSCodium")
      (ls "VSCodium")
    ];
}
