{ inputs, pkgs, ... }:
{
  nix = {
    nrBuildUsers = 0;
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };

    # nix-direnv
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    channel.enable = false;
    # https://github.com/NixOS/nixpkgs/issues/204292
    registry.nixpkgs.flake = inputs.nixpkgs;
    registry.nurpkgs.flake = inputs.nur;

    settings = {
      trusted-users = [ "root" "nomad" ];
      experimental-features = [
        "nix-command"
        "flakes"
        "auto-allocate-uids"
        "cgroups"
        "repl-flake"
        "ca-derivations"
      ];
      nix-path = [
        "nixpkgs=${pkgs.path}"
        "nurpkgs=${inputs.nur}"
      ];
      auto-allocate-uids = true;
      use-cgroups = true;
      auto-optimise-store = true;
      builders-use-substitutes = true;
      keep-derivations = true;
      use-xdg-base-directories = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
}