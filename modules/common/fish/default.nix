{
  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (ls "fish")
    ];
  
  homeModule = { pkgs, ... }:
    let
      tide = pkgs.fishPlugins.tide.src;
      source = f: builtins.readFile ./${f}.fish;
    in {
      programs.fish = {
        enable = true;
        plugins = [{
          name = "tide";
          src = tide;
        }];

        interactiveShellInit = ''
          # direnv hook fish | source
          ${source "config/fish"}

          ${source "completion/sptlrx"}

          # FIXME: Try to disable tide on TTY
          if test "$TERM" != "linux"
            string replace -r '^' 'set -U ' < ${tide}/functions/tide/configure/configs/lean.fish         | source
            string replace -r '^' 'set -U ' < ${tide}/functions/tide/configure/configs/lean_16color.fish | source
            ${source "config/tide"}
          end
        '';
      };
    };
}