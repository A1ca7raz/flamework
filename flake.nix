{
  description = "Flamework 3";

  inputs = {
    # Use inputs from my NUR flake
    nur.url = "github:A1ca7raz/nurpkgs";
    nixpkgs.follows = "nur/nixpkgs";
    flake-utils.follows = "nur/flake-utils";
    flake-compat.follows = "nur/flake-compat";

    # NixosModule Flakes
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
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
#     lanzaboote = {
#       url = "github:nix-community/lanzaboote";
#       inputs.nixpkgs.follows = "nixpkgs";
#       inputs.flake-compat.follows = "flake-compat";
#       inputs.flake-utils.follows = "flake-utils";
#     };
    sops-nix.follows = "nur/sops-nix";
    spicetify-nix = {
      url = "github:A1ca7raz/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
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
          overlays = [ inputs.nur.overlay ];
        };
      in {
        formatter = pkgs.nixpkgs-fmt;
        devShells.default = with pkgs; mkShell { nativeBuildInputs = [ colmena ]; };
      }
    ) // {
      nixosModules = utils.modules // (with inputs; {
        sops = sops-nix.nixosModules.sops;
        impermanence = impermanence.nixosModules.impermanence;
        home = home-manager.nixosModules.home-manager;
#         lanzaboote = lanzaboote.nixosModules.lanzaboote;
        nur = inputs.nur.nixosModule;
      });

      nixosConfigurations = utils.profiles.nixosConfigurations;
      colmena = utils.profiles.colmena;
    };
}
