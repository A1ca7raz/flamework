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
      baidupcs-go
      step-cli
    ];
  };

  nixosModule = { user, tools, pkgs, ... }:
    with tools; mkPersistDirsModule user [
      (c "BaiduPCS-Go")                 # 百度网盘

      # System
      (ls "applications")
      # (ls "networkmanagement")
      (ls "Trash")
      (ls "vulkan")
      ".local/state/wireplumber"

      (ls "qalculate")                # Qalc
    ];
}
