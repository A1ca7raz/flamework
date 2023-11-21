{
  homeModule = { lib, pkgs, inputs, ... }:
  let
    spicetify-nix = inputs.spicetify-nix;
    spicePkgs = spicetify-nix.packages.x86_64-linux.default;
  in {
    imports = [ spicetify-nix.homeManagerModule ];

    programs.spicetify = with spicePkgs; {
      enable = true;
      theme = themes.Dribbblish;
      colorScheme = "rosepine";

      enabledExtensions = with extensions; [
        volumePercentage
        shuffle
        skipOrPlayLikedSongs
      ];
      enabledCustomApps = with apps; [
        lyrics-plus
      ];
    };

    home.packages = with pkgs; [
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
