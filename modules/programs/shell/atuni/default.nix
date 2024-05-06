{
  nixosModule = { lib, user, ... }:
    with lib; mkPersistDirsModule user [
      (ls "atuin")
    ];

  homeModule = { ... }:
    let
      settings = import ./config.nix;
    in {
      programs.fish.interactiveShellInit = ''
        # bind UP on TTY mode
        bind -k up _atuin_bind_up
        bind \eOA _atuin_bind_up
        bind -M insert -k up _atuin_bind_up
        bind -M insert \eOA _atuin_bind_up
        
        # bind Ctrl+UP on PTS mode
        bind \e\[1\;5A _atuin_bind_up
        bind -M insert \e\[1\;5A _atuin_bind_up
      '';

      programs.atuin = {
        enable = true;
        settings = settings;
        flags = [
          "--disable-up-arrow"
        ];
      };
    };
}