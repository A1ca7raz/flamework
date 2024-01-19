{ user, tools, config, ... }:
with tools; let
  inherit (config.lib) themeColor;
  t = x: ".local/share/konsole/${x}";

  path = ./konsole-profile;
  profile_tpl = import /${path}/profile_tpl.nix;
in mkOverlayModule user {
  konsole_profile_dark = {
    text = profile_tpl "Dark";
    target = t "Dark.profile";
  };

  konsole_profile_light = {
    text = profile_tpl "Light";
    target = t "Light.profile";
  };

  konsole_color_dark = {
    text = import /${path}/dark_color.nix themeColor;
    target = t "Blur Dark.colorscheme";
  };

  konsole_color_light = {
    text = import /${path}/light_color.nix themeColor;
    target = t "Blur Light.colorscheme";
  };
}