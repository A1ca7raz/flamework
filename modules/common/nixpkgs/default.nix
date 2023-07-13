{ user, util, ... }:
with util; mkOverlayModule user {
  nixpkgs_config = {
    source = ./config.nix;
    target = c "nixpkgs/config.nix";
  };
}