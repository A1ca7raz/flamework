lib:
rec {
  mkPersistDirsTree = user: dirs: {
    "/nix/persist".users.${user}.directories = dirs;
  };

  mkPersistDirsModule = user: dirs: {
    environment.persistence = mkPersistDirsTree user dirs;
  };

  mkPersistFilesModule = user: files: {
    environment.persistence."/nix/persist".users.${user}.files = files;
  };

  mkOverlayTree = user: sets: {
    users.${user} = sets;
  };

  mkOverlayModule = user: sets: {
    environment.overlay = mkOverlayTree user sets;
  };

  mkHomePackagesTree = list: {
    packages = list;
  };

  mkHomePackagesModule = list: {
    home = mkHomePackagesTree list;
  };

  # https://github.com/xddxdd/nixos-config/blob/master/helpers/fn/service-harden.nix
  hardenService = lib.mapAttrs (_k: lib.mkOptionDefault) {
    AmbientCapabilities = "";
    CapabilityBoundingSet = "";
    LockPersonality = true;
    MemoryDenyWriteExecute = true;
    NoNewPrivileges = true;
    PrivateDevices = true;
    PrivateMounts = true;
    PrivateTmp = true;
    ProcSubset = "pid";
    ProtectClock = true;
    ProtectControlGroups = true;
    ProtectHome = true;
    ProtectHostname = true;
    ProtectKernelLogs = true;
    ProtectKernelModules = true;
    ProtectKernelTunables = true;
    ProtectProc = "invisible";
    ProtectSystem = "strict";
    RemoveIPC = true;
    RestrictAddressFamilies = [
      "AF_UNIX"
      "AF_INET"
      "AF_INET6"
    ];
    RestrictNamespaces = true;
    RestrictRealtime = true;
    RestrictSUIDSGID = true;
    SystemCallArchitectures = "native";
    SystemCallErrorNumber = "EPERM";
    SystemCallFilter = [
      "@system-service"
      # Route-chain and OpenJ9 requires @resources calls
      "~@clock @cpu-emulation @debug @module @mount @obsolete @privileged @raw-io @reboot @swap"
    ];
  };
}
