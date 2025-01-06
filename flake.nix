{
  description = "Flamework 3";

  nixConfig = {
    # https://github.com/A1ca7raz/nurpkgs/blob/main/config.nix
    extra-substituters = [
      "https://cache.garnix.io"
      "https://a1ca7raz-nur.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "a1ca7raz-nur.cachix.org-1:twTlSh62806B8lfG0QQzge4l5srn9Z8/xxyAFauOZnQ="
    ];
  };

  inputs = {
    # Use inputs from my NUR flake
    nur.url = "github:A1ca7raz/nurpkgs";
    nixpkgs.follows = "nur/nixpkgs";
    flake-parts.follows = "nur/flake-parts";
    flake-utils.follows = "nur/flake-utils";
    flake-compat.follows = "nur/flake-compat";

    # NixosModule Flakes
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils.follows = "flake-utils";
    };
    dns = {
      url = "github:nix-community/dns.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    # disko = {
    #   url = "github:nix-community/disko";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote.follows = "nur/lanzaboote";
    sops-nix.follows = "nur/sops-nix";
    spicetify-nix.follows = "nur/spicetify-nix";
    nix-index-database.follows = "nur/nix-index-database";
  };

  outputs =
    inputs@{ self, nixpkgs, flake-parts, ... }:
    let
      lib = import ./flake-modules/lib nixpkgs.lib;
    in
    flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = { inherit lib; };
    } {

      debug = true;
      systems = [
        "x86_64-linux"
      ];

      imports = [
        ./flake-modules/profiles
        ./flake-modules/packages
        ./flake-modules/modules
      ];

      flamework = {
        profiles = {
          profilesPath = ./profiles;
          presetsPath = ./profiles/__templates;
          constantsPath = ./constant;
          enableColmenaHive = true;
        };
        packages.pkgsPath = ./pkgs;
        modules.path = ./modules;
      };

      flake = {
        nixosModules = with inputs; {
          sops = sops-nix.nixosModules.sops;
          impermanence = impermanence.nixosModules.impermanence;
          home = home-manager.nixosModules.home-manager;
          lanzaboote = lanzaboote.nixosModules.lanzaboote;
          nur = inputs.nur.nixosModule;
        };
      };

      perSystem = { config, pkgs, system, ... }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
          overlays = [
            inputs.nur.overlays.default
            inputs.nur.overlays.nixpaks
            self.overlays.pkgs
          ];
        };

        formatter = pkgs.nixpkgs-fmt;

        devShells.default = with pkgs; mkShell {
          nativeBuildInputs = [
            colmena
            flameworkPackages.deploykit
          ];
        };
      };
    };
}
