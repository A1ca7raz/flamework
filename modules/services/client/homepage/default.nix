{ pkgs, lib, ... }:
let
  package = pkgs.homepage-dashboard.override {
    enableLocalIcons = true;
  };

  listenPort = "80";
  listenAddr = "127.0.0.100";
  domain = "home.local";
in {
  systemd.services.homepage-dashboard = {
    description = "Homepage Dashboard";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    environment = {
      HOMEPAGE_CONFIG_DIR = "/var/lib/homepage-dashboard";
      PORT = "${toString listenPort}";
      HOSTNAME = domain;
    };

    serviceConfig = {
      Type = "simple";
      DynamicUser = true;
      StateDirectory = "homepage-dashboard";
      ExecStart = "${lib.getExe package}";
      Restart = "on-failure";
    };
  };

  networking.hosts = {
    ${listenAddr} = [ domain ];
  };
}