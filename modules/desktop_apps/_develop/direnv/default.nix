{
  homeModule = { ... }: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "direnv") (ls "direnv")
    ];
}