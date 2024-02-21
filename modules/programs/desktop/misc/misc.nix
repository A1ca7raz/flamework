{
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      # audacity
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
      step-cli
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

      (c "draw.io")                   # Draw.io
      (c "GIMP")                      # GIMP
      (ls "qalculate")                # Qalc
    ];
}
