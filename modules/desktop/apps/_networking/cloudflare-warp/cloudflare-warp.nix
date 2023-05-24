{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.services.cloudflare-warp;
in {
  options = {
    services.cloudflare-warp = {
      enable = mkEnableOption (lib.mdDoc "cloudflare-warp, a service that replaces the connection between your device and the Internet with a modern, optimized, protocol");

      package = mkOption {
        type = types.package;
        default = pkgs.cloudflare-warp;
        defaultText = literalExpression "pkgs.cloudflare-warp";
        description = lib.mdDoc "The package to use for Cloudflare Warp.";
      };

      user = mkOption {
        type = types.str;
        default = "warp";
        description = lib.mdDoc "User account under which Cloudflare Warp runs.";
      };

      group = mkOption {
        type = types.str;
        default = "warp";
        description = lib.mdDoc "Group under which Cloudflare Warp runs.";
      };

      certificate = mkOption {
        type = with types; nullOr path;
        default = null;
        description = lib.mdDoc ''
          Path to the Cloudflare root certificate. There is a download link in the docs [here](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/install-cloudflare-cert/).
        '';
      };

      udpPort = mkOption {
        type = types.int;
        default = 2408;
        description = lib.mdDoc ''
          The UDP port to open in the firewall. Warp uses port 2408 by default, but fallback ports can be used if that conflicts with another service.  See the [firewall documentation](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/deployment/firewall#warp-udp-ports) for the pre-configured available fallback ports.
        '';
      };

      openFirewall = mkOption {
        type = types.bool;
        default = false;
        description = lib.mdDoc ''
          Opens UDP port in the firewall. See `udpPort` configuration option, and [firewall documentation](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/deployment/firewall#warp-udp-ports).
        '';
      };
    };
  };

  config = mkIf cfg.enable (rec {
    environment.systemPackages = with pkgs; [ cfg.package ];

    security.pki = mkIf (cfg.certificate != null) {
      certificateFiles = [ cfg.certificate ];
    };

    networking.firewall = mkIf cfg.openFirewall {
      allowedUDPPorts = [ cfg.udpPort ];
    };

    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      description = "Cloudflare Warp user";
      home = "/var/lib/cloudflare-warp";
    };

    users.groups.${cfg.group} = {};

    systemd = {
      packages = with pkgs; [
        cfg.package
        lsof
      ];
      services.warp-svc = {
        path = [ pkgs.lsof ];
        after = [ "network-online.target" "systemd-resolved.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          StateDirectory = "cloudflare-warp";
          User = cfg.user;
          Umask = "0077";
          CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_SYS_PTRACE";
          AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_SYS_PTRACE";
          # Hardening
          LockPersonality = true;
          PrivateMounts = true;
          PrivateTmp = true;
          ProtectControlGroups = true;
          ProtectHostname = true;
          ProtectKernelLogs = true;
          ProtectKernelModules = true;
          ProtectKernelTunables = true;
          ProtectProc = "invisible";
          # Leaving on strict activates warp on plus
          ProtectSystem = "full";
          RestrictNamespaces = true;
          RestrictRealtime = true;
        };
      };
    };
  });
}
