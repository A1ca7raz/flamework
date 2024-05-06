{
  nixosModule = { pkgs, lib, user, ... }: {
    virtualisation.waydroid.enable = true;

    environment.systemPackages = [ pkgs.wl-clipboard ];
    environment.persistence = with lib; mkPersistDirsTree user [
      (ls "waydroid")
    ];
  };
}