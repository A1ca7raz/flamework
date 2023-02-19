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
    spicetify-nix = {
      url = github:the-argus/spicetify-nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.flake-utils.follows = "flake-utils";
    };
    # flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      utils = import ./utils lib self;
      nur = import ./pkgs;

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
        overlays = [ nur.overlay ] ++ utils.loader.overlays;
      };
    in {
      packages = nur.packages pkgs;
      legacyPackages = pkgs;

      overlays.default = nur.overlay;

      devShells.x86_64-linux.default = with pkgs; mkShell {
        nativeBuildInputs = [ colmena nvfetcher ];
      };

      nixosModules = utils.module // utils.loader.nixosModules // (with inputs; {
        sops = sops-nix.nixosModules.sops;
        impermanence = impermanence.nixosModules.impermanence;
        disko = disko.nixosModules.disko;
        home = home-manager.nixosModules.home-manager;
        lanzaboote = lanzaboote.nixosModules.lanzaboote;
      });

      nixosConfigurations = utils.loader.profiles.nixosConfigurations;

      colmena = utils.loader.profiles.colmena;
    };
}
