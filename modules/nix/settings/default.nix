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

    # https://github.com/NixOS/nixpkgs/issues/204292
    registry.nixpkgs.flake = inputs.nixpkgs;
    registry.nurpkgs.flake = inputs.nur;

    settings = {
      experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" "repl-flake" ];
      nix-path = [
        "nixpkgs=${pkgs.path}"
        "nurpkgs=${inputs.nur}"
      ];
      auto-allocate-uids = true;
      use-cgroups = true;
      auto-optimise-store = true;
      builders-use-substitutes = true;
      keep-derivations = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [ pkgs.nil ];
}