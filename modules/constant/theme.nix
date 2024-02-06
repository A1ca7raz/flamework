let 
  module = { pkgs, ... }: {
    lib.theme = rec {
      ThemeColor = "Light";  # Dark&Light
      IconTheme = {
        package = pkgs.tela-icon-theme;
        name = "Tela-dracula-light";
      };
      CursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
      PlasmaTheme     = "Win11OS-light";
      ColorScheme     = "My${ThemeColor}";
      KvantumTheme    = "Breeze-Blur-${ThemeColor}";
      KonsoleProfile  = "${ThemeColor}.profile";
    };
  };
in {
  nixosModule = module;
  homeModule = module;
}