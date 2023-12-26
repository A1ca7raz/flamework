{
  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      ".gnupg"
    ];
  
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      paperkey
      qrencode
    ];
  };
}