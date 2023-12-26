{
  # SVP Support:
  # https://lantian.pub/article/modify-computer/nixos-packaging.lantian/#%E5%9B%B0%E9%9A%BEsvp%E7%A8%8B%E5%BA%8F%E6%A3%80%E6%B5%8B%E8%87%AA%E8%BA%AB%E5%AE%8C%E6%95%B4%E6%80%A7bubblewrap
  # https://github.com/LunNova/nixos-configs/blob/dev/users/lun/gui/media/default.nix
  # https://github.com/LunNova/nixos-configs/blob/dev/packages/svpflow/default.nix

  homeModule = { pkgs, ... }:
    with pkgs; let
      scripts =  with mpvScripts; [
        mpris                 # Mpris
        thumbfast             # On-the-fly Thumbnail
        uosc                  # Feature-rich UI
        autoload
        # mpv-playlistmanager   # Playlist
      ];

      # mpvUnwrapped = mpv-unwrapped;
      mpvUnwrapped = mpv-unwrapped.override { vapoursynthSupport = true; };
      mpvPackage = wrapMpv mpvUnwrapped { inherit scripts; };
    in {
      home.packages = [ mpvPackage ];
      # programs.mpv = {
      #   enable = true;
      #   package = pkgs.mpv.override { vapoursynthSupport = true; };  
      # };
    };

  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "mpv")
    ];
}