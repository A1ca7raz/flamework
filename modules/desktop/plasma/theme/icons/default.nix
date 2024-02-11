{
  nixosModule = { config, ... }:
    let
      inherit (config.lib.theme) IconTheme;
    in {
      utils.kconfig.files.kdeglobals.items= [
        { g = "Icons"; k = "Theme"; v = IconTheme.name; }
      ];
    };
  
  homeModule = { config, ... }: {
    home.packages = [ config.lib.theme.IconTheme.package ];
  };
}