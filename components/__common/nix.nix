{ self, inputs, pkgs, ... }:
{
  imports = [ self.nixosModules.nur ];  # Import NUR Repos

  nix = {
    nrBuildUsers = 0;
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
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
      # Garnix
      # substituters = [ "https://cache.garnix.io" ];
      # trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = [ pkgs.nil ];
}