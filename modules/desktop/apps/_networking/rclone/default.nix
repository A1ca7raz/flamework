{ home, pkgs, ... }:
let
  mount_path = ".cache/rclone/fm_secure";
in {
  home.packages = [ pkgs.rclone ];

  sops.secrets.rclone.path = ".config/rclone/rclone.conf";

  systemd.user.services.rclone_fm_secure = {
    Unit = {
      Description = "Rclone Daemon Auto mount fm_secure";
      After = [ "sops-nix.service" ];
    };
    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${mount_path}";
      ExecStart = "${pkgs.rclone}/bin/rclone mount fm_secure: ${mount_path} --vfs-cache-mode writes";
      ExecStop = "${pkgs.util-linux}/bin/umount ${mount_path}";
      # https://discourse.nixos.org/t/fusermount-systemd-service-in-home-manager/5157
      Environment = "PATH=/run/wrappers/bin/:$PATH";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}