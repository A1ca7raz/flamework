{
  homeModule = { pkgs, ... }: {
    programs.mpv = {
      enable = true;
      scripts = [ pkgs.mpvScripts.mpris ];
    };
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (c "mpv")
    ];
}