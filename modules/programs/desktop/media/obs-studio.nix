{
  homeModule = { pkgs, ... }: {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs; with obs-studio-plugins; [
        input-overlay
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
