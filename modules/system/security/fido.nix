{ config, ... }:
let
  enabled = { u2fAuth = true; };
in {
  utils.secrets.u2f_keys.path = ./u2f_keys.enc.json;
  sops.secrets.u2f_keys.mode = "0444";

  security.pam = {
    u2f.enable = true;
    u2f.settings = {
      cue = true;
      authfile = config.sops.secrets.u2f_keys.path;
    };

    services = {
      login = enabled;
      sudo = enabled;
      polkit-1 = enabled;
      kde = enabled;
    };
  };
}
