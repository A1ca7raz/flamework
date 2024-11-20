{
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      # audacity
      # drawio
      fsearch
      libnotify
      libqalculate
      lm_sensors
      anki
      qalculate-qt
      # step-cli
      flameworkPackages.desktop-toolkit
    ];
  };

  nixosModule = { user, lib, pkgs, ... }:
    with lib; mkPersistDirsModule user [
      # System
      (ls "applications")
      # (ls "networkmanagement")
      (ls "Trash")
      (ls "vulkan")

      (ls "qalculate")                # Qalc
    ];
}
