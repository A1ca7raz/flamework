{
  homeModule = { pkgs, ... }: {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs; with obs-studio-plugins; [
        # input-overlay # NOTE: broken on Wayland
        advanced-scene-switcher
        obs-teleport
        obs-source-clone
        obs-replay-source
        obs-composite-blur
        obs-source-switcher
        obs-gradient-source
        obs-text-pthread
        obs-move-transition
        obs-multi-rtmp
        obs-pipewire-audio-capture
        obs-source-record
        obs-vaapi
        obs-vkcapture
      ];
    };
  };

  nixosModule = { user, lib, config, ... }:
    with lib; {
      environment.persistence = mkPersistDirsTree user [
        (c "obs-studio")
      ];

      boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];
    };
}
