{
  homeModule = { ... }: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "direnv") (ls "direnv")
    ];
}