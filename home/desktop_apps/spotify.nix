{ lib, pkgs, inputs, ... }:
let
  spicetify-nix = inputs.spicetify-nix;
  spicePkgs = spicetify-nix.packages.x86_64-linux.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Dribbblish;
    colorScheme = "nord-dark";

    enabledExtensions = with spicePkgs.extensions; [
      volumePercentage
      popupLyrics
      shuffle
      powerBar
      skipOrPlayLikedSongs
    ];

    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
      marketplace
      new-releases
    ];
  };

  # https://github.com/macdems/yet-another-spotify-tray
  home.packages = [ pkgs.yet-another-spotify-tray ];
}