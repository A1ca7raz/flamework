{ user, tools, ... }:
with tools; mkOverlayModule user {
  nixpkgs_config = {
    target = c "nixpkgs/config.nix";
    text = ''
      {
        allowUnfree = true;
      }
    '';
  };
}