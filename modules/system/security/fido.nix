{ config, ... }:
let
  uri = "pam://oxygenlaptop";
  u2fon = { u2fAuth = true; };
in {
  utils.secrets.u2f_keys.enable = true;
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
}
