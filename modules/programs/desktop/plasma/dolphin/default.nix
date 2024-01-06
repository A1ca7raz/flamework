{
  nixosModule = { user, tools, ... }:
    with tools; {
      environment.persistence = mkPersistDirsTree user [
        (ls "dolphin")
      ];

      environment.overlay.users.${user} = {
        dolphinrc = {
          source = ./dolphinrc;
          target = c "dolphinrc";
        };

        kservicemenurc = {
          source = ./kservicemenurc;
          target = c "kservicemenurc";
        };

        dolphin_gui = {
          source = ./dolphinui.rc;
          target = ls "kxmlgui5/dolphin/dolphinui.rc";
        };

        user-places = {
          source = ./user-places.xbel;
          target = ls "user-places.xbel";
        };
      };
    };
  
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.dolphin-nospace ];
  };
}