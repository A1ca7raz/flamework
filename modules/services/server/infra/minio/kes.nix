{ pkgs, lib, config, ... }:
let
  constant = config.lib.services.minio-kes;
in {
  # https://min.io/docs/kes/cli/kes-server/
  systemd.services.minio-kes = {
    description = "MinIO Key Encryption Service";
    documentation = [ "https://github.com/minio/kes/wiki" ];
    requires = [ "netns-veth-minio-kes.service" ];
    after = [ "netns-veth-minio-kes.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      StateDirectory = "kes";
      AmbientCapabilities = [
        "CAP_NET_BIND_SERVICE"  # run KES on a privileged port number
        "CAP_IPC_LOCK"          # Enable memory locking features used to prevent paging.
      ];
      CapabilityBoundingSet = [
        "CAP_NET_BIND_SERVICE"
        "CAP_IPC_LOCK"
      ];
      SecureBits = "keep-caps";

      User = "kes";
      Group = "kes";
      DynamicUser = "yes";
      ProtectProc = "invisible";

      NetworkNamespacePath = "/run/netns/minio-kes";

      LoadCredential = [
        "private.key:/var/lib/acme/insyder.key"
        "public.crt:/var/lib/acme/insyder.crt"
        "config:${./kes.yml}"
      ];
      ExecStart = "${lib.getExe pkgs.kes} server --config %d/config --auth off";

      # Let systemd restart this service always
      Restart = "always";

      # Specifies the maximum file descriptor number that can be opened by this process
      LimitNOFILE = "65536";

      # Specifies the maximum number of threads this process can create
      TasksMax = "infinity";

      # Disable timeout logic and wait until process is stopped
      TimeoutStopSec = "infinity";
      SendSIGKILL = "no";
    };
  };

  # netns
  utils.netns.veth.minio-kes = {
    bridge = "0";
    netns = "minio-kes";
    inherit (constant) ipAddrs;
  };
}