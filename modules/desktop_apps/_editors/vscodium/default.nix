{
  homeModule = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };


  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "VSCodium")
      ".vscode-oss"
    ];
}
