{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "maa")
    ];
  
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      maa-assistant-arknights
      maa-cli
    ];
  };
}