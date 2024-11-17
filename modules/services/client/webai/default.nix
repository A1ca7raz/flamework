{ lib, ... }:
let
  host = "127.0.0.41";
  domain = "ai.local";
  port = 80;
in {
  services.open-webui = {
    enable = true;
    inherit host port;

    environment = {
      WEBUI_URL = "http://${domain}";
      WEBUI_AUTH = "False"; # for Single User Only
    };
  };

  # for listening on 80
  systemd.services.open-webui.serviceConfig = {
    CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
    AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
    PrivateUsers = lib.mkForce false; # FIXME: listening on 80
  };

  networking.hosts = {
    "${host}" = [ domain ];
  };
}
