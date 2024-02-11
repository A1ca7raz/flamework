{
  nixosModule = { user, tools, config, ... }:
    with tools; let
      inherit (config.lib) themeColor;
      t = x: {
        text = profile_tpl x;
        target = ".local/share/konsole/${x}.profile";
      };

      path = ./profiles;
      profile_tpl = import /${path}/profile_tpl.nix;
    in {
      environment.overlay = mkOverlayTree user {
        konsole_profile_dark = t "Dark";
        konsole_profile_light = t "Light";

        konsole_color_dark = {
          text = import /${path}/dark_color.nix themeColor;
          target = t "Blur Dark.colorscheme";
        };

        konsole_color_light = {
          text = import /${path}/light_color.nix themeColor;
          target = t "Blur Light.colorscheme";
        };
      };
    };

  homeModule = { config, lib, ... }:
    let
      inherit (config.lib.theme) KonsoleProfile;
      path = "$HOME/.local/share/konsole";
    in {
      home.activation.setupTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ## Konsole Profile
        ln -sf ${path}/${KonsoleProfile} ${path}/Default.profile
      '';
    };
}