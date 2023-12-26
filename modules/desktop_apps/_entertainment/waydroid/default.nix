{
  nixosModule = { pkgs, tools, user, ... }: {
    virtualisation.waydroid.enable = true;

    environment.systemPackages = [ pkgs.wl-clipboard ];
    environment.persistence = with tools; mkPersistDirsTree user [
      (ls "waydroid")
    ];
  };
}