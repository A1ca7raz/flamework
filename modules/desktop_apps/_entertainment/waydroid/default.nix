{
  nixosModule = { pkgs, util, user, ... }: {
    virtualisation.waydroid.enable = true;

    environment.systemPackages = [ pkgs.wl-clipboard ];
    environment.persistence = with util; mkPersistDirsTree user [
      (ls "waydroid")
    ];
  };
}