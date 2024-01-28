{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.lib.gitea;
  exe = lib.getExe cfg.package;
in with cfg; {
  systemd.tmpfiles.rules = [
    "d '${backupDir}' 0750 ${user} ${group} - -"
    "z '${backupDir}' 0750 ${user} ${group} - -"
    "d '${repositoryRoot}' 0750 ${user} ${group} - -"
    "z '${repositoryRoot}' 0750 ${user} ${group} - -"
    # "d '${stateDir}' 0750 ${user} ${group} - -"
    "d '${stateDir}/conf' 0750 ${user} ${group} - -"
    "d '${customDir}' 0750 ${user} ${group} - -"
    "d '${customDir}/conf' 0750 ${user} ${group} - -"
    "d '${stateDir}/data' 0750 ${user} ${group} - -"
    "d '${stateDir}/log' 0750 ${user} ${group} - -"
    "z '${stateDir}' 0750 ${user} ${group} - -"
    "z '${stateDir}/.ssh' 0700 ${user} ${group} - -"
    "z '${stateDir}/conf' 0750 ${user} ${group} - -"
    "z '${customDir}' 0750 ${user} ${group} - -"
    "z '${customDir}/conf' 0750 ${user} ${group} - -"
    "z '${stateDir}/data' 0750 ${user} ${group} - -"
    "z '${stateDir}/log' 0750 ${user} ${group} - -"

    # If we have a folder or symlink with gitea locales, remove it
    # And symlink the current gitea locales in place
    "L+ '${stateDir}/conf/locale' - - - - ${package.out}/locale"
    "d '${lfsDir}' 0750 ${user} ${group} - -"
    "z '${lfsDir}' 0750 ${user} ${group} - -"
  ];

  systemd.services.gitea = {
    description = "gitea";
    wantedBy = [ "multi-user.target" ];
    path = [ package pkgs.git pkgs.gnupg ];

    environment = {
      USER = user;
      HOME = stateDir;
      GITEA_WORK_DIR = stateDir;
      GITEA_CUSTOM = customDir;
      # CONFIG = "/run/credentials/gitea.service/app.ini";
    };

    preStart = ''
      # run migrations/init the database
      gitea migrate
      echo "Migrate completed."

      # update all hooks' binary paths
      gitea admin regenerate hooks
      echo "Regenerate hooks completed."

      # update command option in authorized_keys
      [[ -r ${cfg.stateDir}/.ssh/authorized_keys ]] && gitea admin regenerate keys
      echo "Regenerate keys completed."

      # create admin user for the first time
      # initial password will be in ${cfg.stateDir}/superuser.lock
      if [[ ! -e ${cfg.stateDir}/superuser.lock ]]; then
        password=$(gitea generate secret SECRET_KEY)
        gitea admin user create --admin \
          --username giteasu \
          --password $password \
          --email gitea@example.com
        echo $password > ${cfg.stateDir}/superuser.lock
      fi
    '';

    serviceConfig = {
      Type = "simple";
      User = user;
      Group = group;
      ExecStart = "${exe} web --pid /run/gitea/gitea.pid";
      Restart = "always";
      RestartSec = "2s";

      # LoadCredential = "app.ini:${config.sops.templates.gitea_config.path}";
      StateDirectory = "gitea";
      WorkingDirectory = stateDir;
      # Runtime directory and mode
      RuntimeDirectory = "gitea";
      RuntimeDirectoryMode = "0755";

      UMask = "0027";
      # Proc filesystem
      ProcSubset = "pid";
      ProtectProc = "invisible";
      # Capabilities
      AmbientCapabilities = "CAP_NET_BIND_SERVICE";
      CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
      SecureBits = "keep-caps";
      # Security
      NoNewPrivileges = true;
      # Sandboxing
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      PrivateDevices = true;
      PrivateUsers = true;
      ProtectHostname = true;
      ProtectClock = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      RestrictAddressFamilies = [ "AF_UNIX" "AF_INET" "AF_INET6" ];
      RestrictNamespaces = true;
      LockPersonality = true;
      MemoryDenyWriteExecute = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      RemoveIPC = true;
      PrivateMounts = true;
      # System Call Filtering
      SystemCallArchitectures = "native";
      SystemCallFilter = [ "~@cpu-emulation @debug @keyring @mount @obsolete @privileged @setuid" "setrlimit" ];
    };
  };

  # Git user
  users.users.${user} = {
    description = "Gitea Service";
    home = stateDir;
    useDefaultShell = true;
    inherit group;
    isSystemUser = true;
  };
  users.groups.${group} = {};
}