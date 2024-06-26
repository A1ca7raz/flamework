{ pkgs, lib, config, ... }:
let
  workDir = "/var/lib/step-ca";

  passwordFile = config.sops.secrets.step-ca_pwd.path;
  configFile = config.sops.secrets.step-ca_cfg.path;
in {
  utils.secrets.step-ca_pwd.enable = true;
  utils.secrets.step-ca_cfg.enable = true;

  # https://github.com/smallstep/certificates/blob/master/systemd/step-ca.service
  systemd.services.step-ca = {
    description = "step-ca service";
    documentation = [
      "https://smallstep.com/docs/step-ca"
      "https://smallstep.com/docs/step-ca/certificate-authority-server-production"
    ];
    # after = [ netnsService "authentik.service" ];
    # bindsTo = [ netnsService ];
    # requires = [ "authentik.service" ];
    wantedBy = [ "multi-user.target" ];
    startLimitIntervalSec = 30;
    startLimitBurst = 3;

    environment = {
      HOME = workDir;
      STEPPATH = workDir;
    };

    serviceConfig = {
      Type = "simple";
      User = "step";
      Group = "step";
      UMask = "0077";
      WorkingDirectory = workDir;
      StateDirectory = "step-ca";

      Restart = "always";

      # Conflict with PrivateNetwork
      NetworkNamespacePath = "/run/netns/step";

      LoadCredential = [
        "password:${passwordFile}"
        "config.json:${configFile}"
      ];

      ExecStart = "${lib.getExe pkgs.step-ca} %d/config.json --password-file %d/password";

      # Process capabilities & privileges
      AmbientCapabilities = "CAP_NET_BIND_SERVICE";
      CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
      SecureBits = "keep-caps";
      NoNewPrivileges = "yes";

      # Sandboxing
      ProtectSystem = "full";
      ProtectHome = "true";
      RestrictNamespaces = "true";
      RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6";
      PrivateTmp = "true";
      PrivateDevices = "true";
      ProtectClock = "true";
      ProtectControlGroups = "true";
      ProtectKernelTunables = "true";
      ProtectKernelLogs = "true";
      ProtectKernelModules = "true";
      LockPersonality = "true";
      RestrictSUIDSGID = "true";
      RemoveIPC = "true";
      RestrictRealtime = "true";
      SystemCallFilter = "@system-service";
      SystemCallArchitectures = "native";
      MemoryDenyWriteExecute = "true";
    };
  };
}