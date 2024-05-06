{
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      # Remove all JetBrains software for now due to broken NUR cache.
      jb-clion-fixed
      jb-datagrip-fixed
      jb-idea-fixed
      jb-pycharm-fixed
    ];
  };

  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "JetBrains") (ls "JetBrains")
    ];
}
