{
  homeModule = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };


  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (c "VSCodium")
      ".vscode-oss"
    ];
}
