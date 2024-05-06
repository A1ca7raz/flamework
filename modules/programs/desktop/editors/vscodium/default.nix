{
  homeModule = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium.override {
        commandLineArgs = "--extensions-dir ~/.local/share/VSCodium/extensions";
      };
    };
  };


  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "VSCodium")
      (ls "VSCodium")
    ];
}
