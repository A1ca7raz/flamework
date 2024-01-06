{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.kate ];
  };

  nixosModule = { user, tools, ... }: with tools; {
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