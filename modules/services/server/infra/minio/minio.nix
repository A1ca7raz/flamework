{ config, lib, pkgs, ... }:
# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/web-servers/minio.nix
let
  configDir = "/var/lib/minio/config";
  dataDir = [ "/mnt/data/0" ];
  rootCredentialsFile = config.sops.secrets.minio_env.path;

  listenAddress = "127.0.0.1:60003";
  consoleAddress = "127.0.0.1:60004";
in {
  utils.secrets.minio_env.enable = true;

  systemd = {
    tmpfiles.rules = [ "d '${configDir}' - minio minio - -" ]
      ++ (map (x: "d '" + x + "' - minio minio - - ") (builtins.filter lib.types.path.check dataDir));

    services.minio = {
      description = "Minio Object Storage";
      documentation = [ "https://min.io/docs/minio/linux/index.html" ];
      requires = [ "authentik.service" ];
      bindsTo = [ "netns-veth-minio.service" ];
      after = [ "netns-veth-minio.service" "authentik.service" "caddy.service" ];
      wantedBy = [ "multi-user.target" ];

      environment = {
        MINIO_REGION = "cn-east-home-01";
        MINIO_BROWSER = "on";
      };

      serviceConfig = {
        Type = "notify";
        User = "minio";
        Group = "minio";
        # DynamicUser = "yes";
        EnvironmentFile = rootCredentialsFile;
        StateDirectory = "minio";
        ExecStart = "${pkgs.minio}/bin/minio server --json --address ${listenAddress} --console-address ${consoleAddress} --config-dir ${configDir} ${toString dataDir}";

        # Let systemd restart this service always
        Restart = "always";

        # Specifies the maximum file descriptor number that can be opened by this process
        LimitNOFILE = 65536;

        # Specifies the maximum number of threads this process can create
        TasksMax = "infinity";

        # Disable timeout logic and wait until process is stopped
        TimeoutStopSec = "infinity";
        SendSIGKILL = "no";

        # TLS certs
        LoadCredential = [
          "private.key:/var/lib/acme/insyder.key"
          "public.crt:/var/lib/acme/insyder.crt"
        ];

        # netns
        NetworkNamespacePath = "/run/netns/proxy";
        
        AmbientCapabilities = "CAP_NET_BIND_SERVICE";
        CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
        SecureBits = "keep-caps";

        # Sandboxing
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        PrivateUsers = true;
        PrivateDevices = true;
        PrivateMounts = true;
        PrivateTmp = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = "strict";
        RemoveIPC = true;
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        UMask = "0077";
        SystemCallArchitectures = "native";
        SystemCallErrorNumber = "EPERM";
        SystemCallFilter = "@system-service";
        RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
        ReadWritePaths = dataDir;
      };
    };
  };

  users.users.minio = {
    group = "minio";
    home = "/var/lib/minio";
    isSystemUser = true;
  };
  users.groups.minio = {};
}