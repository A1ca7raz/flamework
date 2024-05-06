{ user, lib, ... }:
with lib; mkOverlayModule user {
  nixpkgs_config = {
    target = c "nixpkgs/config.nix";
    text = ''
      {
        allowUnfree = true;
      }
    '';
  };
}