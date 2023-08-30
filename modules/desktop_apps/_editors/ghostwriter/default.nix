{
  nixosModule = { user, util, ... }:
    with util; {
      environment = {
        persistence = mkPersistDirsTree user [
          (ls "ghostwriter")
        ];

        overlay = mkOverlayTree user {
          conf = {
            source = ./ghostwriter.conf;
            target = c "ghostwriter/ghostwriter.conf";
          };

          theme = {
            source = ./theme.json;
            target = ls "ghostwriter/themes/Mytheme.json";
          };
        };
      };
    };

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.ghostwriter ];
  };
}
