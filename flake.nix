{
  description = "Flamework 2";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Other flake utils
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # NixosModule Flakes
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils.follows = "flake-utils";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    let
      SYSTEM = [ "x86_64-linux" ];

      lib = nixpkgs.lib;
      utils = import ./utils lib self;
    in flake-utils.lib.eachSystem SYSTEM (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      in rec {
        formatter = pkgs.nixpkgs-fmt;
        devShells.default = with pkgs; mkShell { nativeBuildInputs = [ colmena nvfetcher ]; };
      }
    ) // {
      nixosModules = utils.modules // (with inputs; {
        sops = sops-nix.nixosModules.sops;
        impermanence = impermanence.nixosModules.impermanence;
        home = home-manager.nixosModules.home-manager;
      });

      overlays.nixpkgs = final: prev: {};

      nixosConfigurations = utils.profiles.nixosConfigurations;
      colmena = utils.profiles.colmena;
    };
}
