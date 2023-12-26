lib: self:
let
  path = builtins.toPath ./..;
  inputs = self.inputs;
  tools = import ./lib lib;
  
  moduleRegistry = import ./registry.nix;
  moduleScanner = new: sum:
    if new.type == "dir"
    then { ${new.name} = tools.mkModuleTreeFromDirs /${path}/${new.path}; } // sum
    else if new.type == "file"
    then { ${new.name} = tools.mkModuleTreeFromFiles /${path}/${new.path}; } // sum
    else sum;
in {
  constant = lib.recursiveUpdate (import ./lib/constant.nix lib).constant (
    if (builtins.pathExists /${path}/constant.nix)
    then (import /${path}/constant.nix)
    else {}
  );

  # Load Flake Utilities
  profiles = import ./profiles { inherit self path inputs lib tools; };

  # Load User-defined Modules
  modules = (lib.fold moduleScanner {} moduleRegistry) // {
    # Load Module Utilities 
    utils = { lib, ... }: {      
      imports = tools.foldGetDir
        ./modules
        []
        (x: y: [ ./modules/${x} ] ++ y);      
    };
  };
}
