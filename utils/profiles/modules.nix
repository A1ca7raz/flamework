{ lib, self, path, inputs, tools, ... }:
{
  modules,
  users,
  targetUser
}:
with lib; with builtins; with tools;
let
  localUser = if targetUser == "root" then [] else [ targetUser ];

  module_list = getModuleList modules;

  nixosModules = filterNixosModules module_list;
  nixosModulesUser = filterNixosModulesUser localUser module_list;
  homeModules = filterHomeModules localUser module_list;

  # 用户指定的module
  specificHomeModules = mapAttrsToList
    (name: value:
      let
        _modules = getModuleList (attrByPath [ "modules" ] {} value);
        _nixosModules_user = filterNixosModulesUser [name] _modules;
        _homeModules_user = filterHomeModules [name] _modules;
      in
        { ... }: {
          imports = _nixosModules_user ++ _homeModules_user;
        }
    ) users;
in
  nixosModules ++ nixosModulesUser ++ homeModules ++ specificHomeModules
