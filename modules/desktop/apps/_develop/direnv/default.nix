{
  homeModule = { ... }: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (c "direnv") (ls "direnv")
    ];
}