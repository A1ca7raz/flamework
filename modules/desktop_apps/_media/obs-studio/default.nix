{
  homeModule = { pkgs, ... }: {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs; with obs-studio-plugins; [
        input-overlay
        obs-gstreamer
        obs-move-transition
        obs-multi-rtmp
        obs-pipewire-audio-capture
        obs-source-record
        obs-vaapi
        obs-vkcapture
      ];
    };
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (c "obs-studio")
    ];
}
