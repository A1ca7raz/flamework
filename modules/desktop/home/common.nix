{ path, pkgs, ... }:
{
  home.sessionPath = [ "$HOME/.local/bin" ];
  home.stateVersion = "23.05";

  # programs.home-manager.enable = true;
  # https://github.com/nix-community/home-manager/issues/3211
  home.packages = [ pkgs.home-manager ];

  sops = {
    age = {
      keyFile = "/var/lib/age.home.key";
      sshKeyPaths = [];
      generateKey = false;
    };
    gnupg.sshKeyPaths = [];
  };
}