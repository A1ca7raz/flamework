{ config, pkgs, ... }:
let
  uri = "pam://oxygenlaptop";
  u2fon = { u2fAuth = true; };
in
{
  sops.secrets.u2f_keys.mode = "0444";

  security.pam = {
    u2f = {
      enable = true;
      cue = true;
      control = "sufficient";

      origin = uri;
      appId = uri;
      authFile = config.sops.secrets.u2f_keys.path;
    };

    services = {
      login = u2fon;
      sudo = u2fon;
      polkit-1 = u2fon;
      kde = u2fon;
    };
  };

  services.udev.packages = [ pkgs.yubikey-personalization ];
}