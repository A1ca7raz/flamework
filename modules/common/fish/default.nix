{
  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
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

      shellInit = ''
        string replace -r '^' 'set -U ' < ${tide}/functions/tide/configure/configs/lean.fish         | source
        string replace -r '^' 'set -U ' < ${tide}/functions/tide/configure/configs/lean_16color.fish | source
        direnv hook fish | source

        ${source "config/fish"}
        ${source "config/tide"}
        ${source "completion/sptlrx"}
      '';
    };
  };
}