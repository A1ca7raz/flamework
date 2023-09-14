{
  homeModule = { lib, pkgs, inputs, ... }:
  let
    spicetify-nix = inputs.spicetify-nix;
    spicePkgs = spicetify-nix.packages.x86_64-linux.default;
  in {
    imports = [ spicetify-nix.homeManagerModule ];

    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.Dribbblish;
      colorScheme = "white";

      enabledExtensions = with spicePkgs.extensions; [
        volumePercentage
        shuffle
        powerBar
        skipOrPlayLikedSongs
      ];
      enabledCustomApps = with spicePkgs.apps; [
        lyrics-plus
      ];
    };

    home.packages = with pkgs; [
      yet-another-spotify-tray    # Tray
      sptlrx                      # Command-line Lyrics
      playerctl
    ];
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      (c "spotify")
      (c "sptlrx")
    ];
}