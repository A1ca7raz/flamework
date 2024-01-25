{ inputs, pkgs, config, lib, tools, ... }:
let
  authentikComponents = inputs.authentik-nix.packages.x86_64-linux;
  constant = config.lib.services;

  settings = {
    blueprints_dir = "${authentikComponents.staticWorkdirDeps}/blueprints";
    template_dir = "${authentikComponents.staticWorkdirDeps}/templates";

    postgresql = {
      user = "authentik";
      name = "authentik";
      host = tools.removeCIDRSuffix (lib.elemAt constant.postgresql.ipAddrs 0);
    };
  };

  authentik-ldap = {
    enable = false;
    environmentFile = null;
  };
in {
  systemd.services =
    let
      settingsFormat = pkgs.formats.yaml {};

      configFile = settingsFormat.generate "authentik.yml" settings;
      environmentFile = config.sops.secrets.authentik_env.path;

      mountOptions = {
        PrivateMounts = "yes";
        BindReadOnlyPaths = [
          "${configFile}:/etc/authentik/config.yml"
          # https://goauthentik.io/docs/installation/docker-compose#explanation
          "${pkgs.tzdata}/share/zoneinfo/UTC:/etc/localtime"
        ];
      };

      commonOptions = {
        DynamicUser = "yes";
        User = "authentik";
        EnvironmentFile = [ environmentFile ];
        NetworkNamespacePath = "/run/netns/proxy";
      };
    in {
      authentik-migrate = {
        requiredBy = [ "authentik.service" ];
        requires = [ "postgresql.service" "redis-authentik.service" ];
        bindsTo = [ "netns-veth-authentik.service" ];
        after = [
          "postgresql.service"
          "netns-veth-authentik.service"
          "redis-authentik.service"
        ];
        before = [ "authentik.service" ];
        restartTriggers = [ configFile ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${authentikComponents.migrate}/bin/migrate.py";
        } // mountOptions // commonOptions;
      };

      authentik-worker = {
        requiredBy = [ "authentik.service" ];
        bindsTo = [ "netns-veth-authentik.service" ];
        before = [ "authentik.service" ];
        after = [ "netns-veth-authentik.service" ];
        restartTriggers = [ configFile ];
        preStart = ''
          ln -svf ${authentikComponents.staticWorkdirDeps}/* /run/authentik/
        '';
        serviceConfig = {
          RuntimeDirectory = "authentik";
          WorkingDirectory = "%t/authentik";
          # TODO maybe make this configurable
          ExecStart = "${authentikComponents.celery}/bin/celery -A authentik.root.celery worker -Ofair --max-tasks-per-child=1 --autoscale 3,1 -E -B -s /tmp/celerybeat-schedule -Q authentik,authentik_scheduled,authentik_events";
          # LoadCredential = mkIf (cfg.nginx.enable && cfg.nginx.enableACME) [
          #   "${cfg.nginx.host}.pem:${config.security.acme.certs.${cfg.nginx.host}.directory}/fullchain.pem"
          #   "${cfg.nginx.host}.key:${config.security.acme.certs.${cfg.nginx.host}.directory}/key.pem"
          # ];
        } // mountOptions // commonOptions;
      };

      authentik = {
        wantedBy = [ "multi-user.target" ];
        bindsTo = [ "netns-veth-authentik.service" ];
        after = [
          "network-online.target"
          "postgresql.service"
          "redis-authentik.service"
          "netns-veth-authentik.service"
        ];
        restartTriggers = [ configFile ];
        preStart = ''
          ln -svf ${authentikComponents.staticWorkdirDeps}/* /var/lib/authentik/
        '';
        serviceConfig = {
          Environment = [
            "AUTHENTIK_ERROR_REPORTING__ENABLED=false"
            "AUTHENTIK_DISABLE_UPDATE_CHECK=true"
            "AUTHENTIK_DISABLE_STARTUP_ANALYTICS=true"
            "AUTHENTIK_AVATARS=initials"
          ];
          StateDirectory = "authentik";
          UMask = "0027";
          # TODO /run might be sufficient
          WorkingDirectory = "%S/authentik";
          ExecStart = "${authentikComponents.gopkgs}/bin/server";
        } // mountOptions // commonOptions;
      };

      authentik-ldap =
        let
          cfg = authentik-ldap;
        in lib.mkIf cfg.enable {
          wantedBy = [ "multi-user.target" ];
          requires = [ "netns-veth-authentik.service" ];
          after = [
            "network-online.target"
            "authentik.service"
            "netns-veth-authentik.service"
          ];
          restartTriggers = [ configFile ];
          serviceConfig = {
            RuntimeDirectory = "authentik-ldap";
            UMask = "0027";
            WorkingDirectory = "%t/authentik-ldap";
            DynamicUser = "yes";
            User = "authentik";
            ExecStart = "${authentikComponents.gopkgs}/bin/ldap";
            EnvironmentFile = lib.mkIf (cfg.environmentFile != null) [ cfg.environmentFile ];
            Restart = "on-failure";
            NetworkNamespacePath = "/run/netns/proxy";
          };
        };
    };
}