# https://github.com/poscat0x04/nixos-configuration/blob/master/machines/hyperion/services/ocis.nix
{ config, pkgs, lib, ... }:
let
  # https://github.com/owncloud/ocis
  ocis-bin = "${pkgs.ocis-bin}/bin/ocis";

  domain = lib.elemAt config.lib.services.ocis.domains 0;
  microServices = import ./micro_services.nix;
in {
  # systemd.tmpfiles.rules = [
  #   "d '/var/lib/ocis/config' 0750 ocis ocis - -"
  # ];

  systemd.services.ocis = {
    description = "ownCloud Infinite Scale Stack";
    wantedBy = [ "multi-user.target" ];

    environment = {
      OCIS_RUN_SERVICES = microServices;
      OCIS_URL = "https://${domain}";
      OCIS_BASE_DATA_PATH = "/var/lib/ocis";
      # OCIS_CONFIG_DIR = "/run/credentials/ocis.service/";
      OCIS_CONFIG_DIR = "/var/lib/ocis/conf/";
    };

    serviceConfig = {
      User = "ocis";
      Group = "ocis";
      ExecStart = "${ocis-bin} server";
      Restart = "always";
      StateDirectory = "ocis";

      DynamicUser = true;
      EnvironmentFile = config.sops.templates.ocis_env.path;
      # LoadCredential = "ocis.yaml:${config.sops.templates.ocis.path}";

      # Capabilities
      CapabilityBoundingSet = "";
      # Proc filesystem
      ProcSubset = "pid";
      ProtectProc = "invisible";
      # Security
      NoNewPrivileges = true;
      # Sandboxing
      PrivateTmp = true;
      PrivateDevices = true;
      PrivateUsers = true;
      ProtectSystem = "strict";
      LockPersonality = true;
      ProtectClock = true;
      ProtectHome = true;
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectControlGroups = true;
      RestrictAddressFamilies = [ "AF_UNIX" "AF_INET" "AF_INET6" ];
      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      MemoryDenyWriteExecute = true;
      RemoveIPC = true;
      PrivateMounts = true;
      # System Call Filtering
      SystemCallArchitectures = "native";
      SystemCallFilter = [ "~@cpu-emulation @debug @keyring @mount @obsolete @privileged @setuid" "setrlimit" ];
    };
  };
}