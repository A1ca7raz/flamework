{
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      # audacity
      barrier
      # drawio
      fsearch
      # gimp
      inkscape
      libnotify
      libqalculate
      lm_sensors
      anki
      qalculate-qt
      sbctl
      sops
      baidupcs-go
    ];
  };

  nixosModule = { user, tools, pkgs, ... }:
    with tools; mkPersistDirsModule user [
      (c "sops")                        # SOPS
      (c "BaiduPCS-Go")                 # 百度网盘

      # System
      (ls "applications")
      (ls "gvfs-metadata")
      (c "libaccounts-glib")
      # (ls "networkmanagement")
      (ls "Trash")
      (ls "vulkan")
      ".local/state/wireplumber"

      (ls "barrier")                  # Barrier
      (c "draw.io")                   # Draw.io
      (c "GIMP")                      # GIMP
      (ls "qalculate")                # Qalc
    ];
}