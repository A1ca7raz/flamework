{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.kdePackages.kate ];
  };

  nixosModule = { user, lib, ... }: with lib; {
    environment = {
      overlay = mkOverlayTree user {
        katerc = {
          source = ./katerc;
          target = c "katerc";
        };
      };

      persistence = mkPersistDirsTree user [
        (c "kate")
        (ls "kate")
      ];
    };
  };
}