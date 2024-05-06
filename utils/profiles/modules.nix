{ lib, self, path, inputs, ... }:
{
  modules,
  users,
  targetUser
}:
with lib; with builtins;
let
  localUser = if targetUser == "root" then [] else [ targetUser ];

  module_list = getModuleList modules;

  nixosModules = filterNixosModules module_list;
  nixosModulesUser = filterNixosModulesUser localUser module_list;
  homeModules = filterHomeModules localUser module_list;

  _enableHomeManager = homeModules != [];

  # 用户指定的module
  # specificUserModules = mapAttrsToList
  #   (name: value:
  #     let
  #       _modules = getModuleList (attrByPath [ "modules" ] [] value);
  #       _nixosModules_user = filterNixosModulesUser [name] _modules;
  #       _homeModules_user = filterHomeModules [name] _modules;
  #     in
  #       { ... }: {
  #         imports = _nixosModules_user ++ _homeModules_user;
  #       }
  #   ) users;

  specificUserModules = foldlAttrs
    (acc: name: value:
      let
        _modules = getModuleList (attrByPath [ "modules" ] [] value);
        _nixosModules_user = filterNixosModulesUser [name] _modules;
        _homeModules_user = filterHomeModules [name] _modules;
      in {
        _enableHomeManager = acc._enableHomeManager || (_homeModules_user != []);
        modules = acc.modules ++ [({ ... }: { imports = _nixosModules_user ++ _homeModules_user; })];
      }
    ) { _enableHomeManager = false; modules = []; } users;
in {
  modules = nixosModules ++ nixosModulesUser ++ homeModules ++ specificUserModules.modules;
  enableHomeManager = _enableHomeManager || specificUserModules._enableHomeManager;
}
  
