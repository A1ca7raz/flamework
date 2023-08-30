{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.kate ];
  };

  nixosModule = { user, util, ... }:
  with util; {
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