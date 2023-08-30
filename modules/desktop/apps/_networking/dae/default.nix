{ config, pkgs, lib, ... }:
with lib; {
  users.users.dae = {
    description = "dae deamon user";
    isSystemUser = true;
    group = "dae";
  };
  users.groups.dae = {};

  networking.firewall.allowedTCPPorts = [ 12345 ];
  networking.firewall.allowedUDPPorts = [ 12345 ];

  systemd.services.dae =
  let
    dae = getExe pkgs.dae;
    caps = [
      "CAP_BPF"
      "CAP_NET_ADMIN"
      "CAP_NET_BIND_SERVICE"
    ];
    geoip = "${pkgs.clash-rules-dat-geoip}/share/clash/GeoIP.dat";
    geosite = "${pkgs.clash-rules-dat-geosite}/share/clash/GeoSite.dat";
  in {
    path = with pkgs; [ coreutils ];
    unitConfig = {
      Description = "dae Service";
      Documentation = "https://github.com/daeuniverse/dae";
      After = [ "network-online.target" "systemd-sysctl.service" ];
      Wants = [ "network-online.target" ];
    };

    serviceConfig = {
      User = "root";
      # User = "dae";
      # CapabilityBoundingSet = caps;
      # AmbientCapabilities = caps;
      LoadCredential = "config:${./config.dae}";

      ExecStartPre = [
        "ln -sf ${geoip} $STATE_DIRECTORY/geoip.dat"
        "ln -sf ${geosite} $STATE_DIRECTORY/geosite.dat"
        "${dae} validate -c %d/config"
      ];
      ExecStart = "${dae} run --disable-timestamp -c %d/config  ${cfg.extraArgs}";
      ExecReload = "${dae} reload $MAINPID";
      StateDirectory = "dae";
      LimitNPROC = 512;
      LimitNOFILE = 1048576;
      Restart = "on-abnormal";
      Type = "notify";
    };

    wantedBy = [ "multi-user.target" ];
  };
}