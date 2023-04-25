{
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      jb-clion-fixed
      jb-datagrip-fixed
      jb-idea-fixed
      jb-pycharm-fixed
    ];
  };


  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (c "JetBrains") (ls "JetBrains")
    ];
}