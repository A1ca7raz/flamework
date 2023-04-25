{
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      steam-run
      protonup-ng
    ];
  };

  nixosModule = { user, ... }: {
    programs.steam.enable = true;
    environment.persistence."/nix/persist".users.${user}.directories = [
      ".local/share/Steam"
      ".steam"
    ];
  };
}

