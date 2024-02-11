{
  nixosModule = { config, ... }:
    let
      inherit (config.lib.theme) CursorTheme;
    in {
      utils.kconfig.files.kcminputrc.items= [
        { g = "Mouse"; k = "cursorTheme"; v = CursorTheme.name; }
      ];
    };
  
  homeModule = { config, ... }: {
    home.packages = [ config.lib.theme.CursorTheme.package ];
  };
}