{
  description = "Flamework";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.utils.follows = "flake-utils";
    };
    # flake-utils.url = "github:numtide/flake-utils";
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.flake-utils.follows = "flake-utils";
    # };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      utils = import ./utils lib self;

      SYSTEM = "x86_64-linux";

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
        overlays = utils.loader.overlays ++ [
          inputs.colmena.overlay
        ];
      };
    in {
      test = self;
      packages = pkgs;
      devShell = with pkgs; mkShell {
        nativeBuildInputs = [ colmena ];
      };

      nixosModules = utils.module // utils.loader.nixosModules // {
        sops = inputs.sops-nix.nixosModules.sops;
        impermanence = inputs.impermanence.nixosModules.impermanence;
        disko = inputs.disko.nixosModules.disko;
        home = inputs.home-manager.nixosModules.home-manager;
        # lanzaboote = inputs.lanzaboote.nixosModules.lanzaboote;
      };

      nixosConfigurations = utils.loader.profiles.nixosConfigurations;

      colmena = utils.loader.profiles.colmena;
    };
}
