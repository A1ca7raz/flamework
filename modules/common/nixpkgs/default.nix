{ user, tools, ... }:
with tools; mkOverlayModule user {
  nixpkgs_config = {
    source = ./config.nix;
    target = c "nixpkgs/config.nix";
  };
}