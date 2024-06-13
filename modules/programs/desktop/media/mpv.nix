# SVP Support:
# https://lantian.pub/article/modify-computer/nixos-packaging.lantian/#%E5%9B%B0%E9%9A%BEsvp%E7%A8%8B%E5%BA%8F%E6%A3%80%E6%B5%8B%E8%87%AA%E8%BA%AB%E5%AE%8C%E6%95%B4%E6%80%A7bubblewrap
# https://github.com/LunNova/nixos-configs/blob/dev/users/lun/gui/media/default.nix
# https://github.com/LunNova/nixos-configs/blob/dev/packages/svpflow/default.nix
{ home, pkgs, ... }:
with pkgs; let
  mpvPackage = mpv-unwrapped.wrapper {
    mpv = mpv-unwrapped.override { vapoursynthSupport = true; };
    scripts = with mpvScripts; [
      mpris                 # Mpris
      thumbfast             # On-the-fly Thumbnail
      uosc                  # Feature-rich UI
      autoload
    ];
  };
in {
  home.packages = [ mpvPackage ];
  xdg.configFile.mpvConf = {
    target = "mpv/mpv.conf";
    text = ''
      profile=gpu-hq
      scale=ewa_lanczossharp
      cscale=ewa_lanczossharp
      video-sync=display-resample
      interpolation
      tscale=oversample
      save-position-on-quit
      hwdec=auto
      volume-max=150
    '';
  };
  xdg.configFile.mpvInputConf = {
    target = "mpv/input.conf";
    text = ''
      [	add speed -0.25
      ]	add speed 0.25
    '';
  };
  xdg.configFile.mpvUoscConf = {
    target = "mpv/script-opts/uosc.conf";
    text = ''
      timeline_style=bar
      timeline_size=25
      timeline_opacity=0.7i

      controls_margin=4
      controls_spacing=4

      volume_size=35
      volume_size_fullscreen=40
      volume_opacity=0.5
      volume_step=5
    '';
  };
}