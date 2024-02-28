{ inputs, pkgs, config, lib, tools, ... }:
let
  authentikComponents = inputs.authentik-nix.packages.x86_64-linux;
  constant = config.lib.services;
  healthCheckURL = "https://${lib.elemAt config.lib.services.authentik.domains 0}/-/health/ready/";

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

  serviceDefaults = {
    DynamicUser = true;
    User = "authentik";
    EnvironmentFile = [ config.sops.secrets.authentik_env.path ];
  };
  akOptions = with lib; flatten (mapAttrsToList
    # Map defaults for each authentik service (listed above) to command line parameters for
    # `systemd-run(1)` in order to spin up an environment with correct (dynamic) user,
    # state directory and environment to run `ak` inside.
    (k: vs: map
      (v: "--property ${k}=${if isBool v then boolToString v else toString v}")
      (toList vs))
    # Read serviceDefaults from `authentik.service`. That way, module system primitives (mk*)
    # can be used inside `serviceDefaults` and it doesn't need to be evaluated here again.
    (getAttrs (attrNames serviceDefaults) config.systemd.services.authentik.serviceConfig // {
      StateDirectory = "authentik";
    }));
  akScript = pkgs.writeShellScriptBin "ak" ''
    exec ${config.systemd.package}/bin/systemd-run --pty --collect \
      ${lib.concatStringsSep " \\\n" akOptions} \
      --working-directory /var/lib/authentik \
      -- ${authentikComponents.manage}/bin/manage.py "$@"
  '';
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
        path = [ akScript ];
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
        path = [ akScript ];
        serviceConfig = {
          RuntimeDirectory = "authentik";
          WorkingDirectory = "%t/authentik";
          # TODO maybe make this configurable
          ExecStart = "${authentikComponents.manage}/bin/manage.py worker";
        } // mountOptions // commonOptions;
      };

      authentik = {
        wantedBy = [ "multi-user.target" ];
        bindsTo = [ "netns-veth-authentik.service" ];
        after = [
          "postgresql.service"
          "redis-authentik.service"
          "netns-veth-authentik.service"
        ];
        restartTriggers = [ configFile ];
        preStart = ''
          ln -svf ${authentikComponents.staticWorkdirDeps}/* /var/lib/authentik/
        '';
        path = [ pkgs.curl akScript ];
        serviceConfig = {
          Type = "notify";
          NotifyAccess = "all";
          Environment = [
            "AUTHENTIK_ERROR_REPORTING__ENABLED=false"
            "AUTHENTIK_DISABLE_UPDATE_CHECK=true"
            "AUTHENTIK_DISABLE_STARTUP_ANALYTICS=true"
            "AUTHENTIK_AVATARS=initials"
          ];
          StateDirectory = "authentik";
          UMask = "0027";

          WorkingDirectory = "%S/authentik";
          DynamicUser = "yes";
          User = "authentik";
          EnvironmentFile = [ environmentFile ];
          NetworkNamespacePath = "/run/netns/proxy";
          PrivateMounts = "yes";
          BindReadOnlyPaths = [
            "${configFile}:/etc/authentik/config.yml"
            # https://goauthentik.io/docs/installation/docker-compose#explanation
            "${pkgs.tzdata}/share/zoneinfo/UTC:/etc/localtime"
          ];
        };

        script = ''
          env -u NOTIFY_SOCKET ${authentikComponents.gopkgs}/bin/server &

          while sleep 5; do
            status=$(curl ${healthCheckURL} -o /dev/null -s -w "%{http_code}")
            if [[ $status = 204 ]]; then
              sleep 5
              systemd-notify --ready --status="Authentik health check succeeded."
              echo "Authentik health check succeeded."
              break
            fi
            systemd-notify --status="Authentik health check failed. Try again. (HTTP_CODE:$status)"
            echo "Authentik health check failed. Try again. (HTTP_CODE:$status)"
          done
          echo "End of Authentik script"
          wait
        '';
      };

      authentik-ldap =
        let
          cfg = authentik-ldap;
        in lib.mkIf cfg.enable {
          wantedBy = [ "multi-user.target" ];
          requires = [ "netns-veth-authentik.service" ];
          after = [
            "authentik.service"
            "netns-veth-authentik.service"
          ];
          restartTriggers = [ configFile ];
          path = [ akScript ];
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
