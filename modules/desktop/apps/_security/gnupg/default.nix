{
  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      ".gnupg"
    ];
  
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      paperkey
      qrencode
    ];
  };
}