{ ... }: {}
# { config, pkgs, lib, ... }:
# with lib; {
#   users.users.dae = {
#     description = "dae deamon user";
#     isSystemUser = true;
#     group = "dae";
#   };
#   users.groups.dae = {};

#   networking.firewall.allowedTCPPorts = [ 12345 ];
#   networking.firewall.allowedUDPPorts = [ 12345 ];

#   systemd.services.dae =
#   let
#     dae = getExe pkgs.dae;
    
#     caps = [
#       "CAP_BPF"
#       "CAP_NET_ADMIN"
#       "CAP_NET_BIND_SERVICE"
#     ];
#     geoip = "${pkgs.clash-rules-dat-geoip}/share/clash/GeoIP.dat";
#     geosite = "${pkgs.clash-rules-dat-geosite}/share/clash/GeoSite.dat";
#     startScript = pkgs.writeShellScriptBin "dae-service-start" ''
#       CONF_DIR=\$\{STATE_DIRECTORY:-/var/lib/clash}
#       CONF=$1
#       echo "Config Path: $CONF"
#       mkdir -p $CONF_DIR
#       ${dae} validate -c $CONF

#       ln -sf ${pkgs.clash-rules-dat-geoip}/share/clash/GeoIP.dat $CONF_DIR/geoip.dat
#       ln -sf ${pkgs.clash-rules-dat-geosite}/share/clash/GeoSite.dat $CONF_DIR/geosite.dat
#       ${dae} run --disable-timestamp -c $CONF
#     '';
#   in {
#     path = with pkgs; [ coreutils ];
#     unitConfig = {
#       Description = "dae Service";
#       Documentation = "https://github.com/daeuniverse/dae";
#       After = [ "network-online.target" "systemd-sysctl.service" ];
#       Wants = [ "network-online.target" ];
#     };

#     serviceConfig = {
#       User = "root";
#       # User = "dae";
#       # CapabilityBoundingSet = caps;
#       # AmbientCapabilities = caps;
#       LoadCredential = "config.dae:${./config.dae}";

#       ExecStart = "${getExe startScript} %d/config.dae";
#       ExecReload = "${dae} reload $MAINPID";
#       StateDirectory = "dae";
#       LimitNPROC = 512;
#       LimitNOFILE = 1048576;
#       Restart = "on-abnormal";
#       Type = "notify";
#     };

#     wantedBy = [ "multi-user.target" ];
#   };
# }