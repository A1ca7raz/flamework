{ util, lib, self, path, inputs, constant, ... }@args: modules:
with lib; with builtins; with util;
let
  module_list = getModuleList modules.use;

  nixosModules = filterNormalNixosModules module_list;
  specialNixosModules = filterSpecialNixosModules modules.homeUsers module_list;
  commonHomeModules = filterHomeModules modules.homeUsers module_list;

  specialUserModules = mapAttrsToList
    (name: value:
      let
        _modules = getModuleList value;
        _nixosModules = filterNormalNixosModules _modules;
        _specific_nixosModules = filterSpecialNixosModules [name] _modules;
        _homeModules = filterHomeModules [name] _modules;
      in
        { ... }: {
          imports = _nixosModules ++ _specific_nixosModules ++ _homeModules;
        }
    ) modules.users;
in
  nixosModules ++ specialNixosModules ++ commonHomeModules ++ specialUserModules
