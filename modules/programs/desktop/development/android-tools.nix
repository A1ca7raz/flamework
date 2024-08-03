{
  nixosModule = { pkgs, user, lib, ... }: {
    # Android-Tools
    programs.adb.enable = true;
    services.udev.packages = [ pkgs.android-udev-rules ];

    environment.persistence = lib.mkPersistDirsTree user [
      ".android"
    ];
  };

  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      scrcpy
    ];
  };
}

