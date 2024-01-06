{
  homeModule = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        steam-run
        protonup-ng
      ];

      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
      };
    };
  };

  nixosModule = { user, ... }: {
    programs.steam.enable = true;
    environment.persistence."/nix/persist".users.${user}.directories = [
      ".local/share/Steam"
      ".steam"
    ];
  };
}

