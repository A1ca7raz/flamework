lib:
{
  modules,
  users,
  targetUser
}:
let
  inherit (lib)
    unique
    foldlAttrs
    attrByPath
    foldr
  ;

  inherit (builtins)
    attrNames
  ;

  inherit (import ./lib lib)
    classifyModules
  ;

  localUsers =
    if targetUser == "root"
    then attrNames users
    else unique (attrNames users ++ [ targetUser ]);

  moduleAttrs = classifyModules modules localUsers;

  nixosModules = moduleAttrs.nixosModules;
  sharedHomeModules = moduleAttrs.homeModules;

  _enableHomeManager = sharedHomeModules != [];

  specificUserModules = foldlAttrs
    (acc: name: value:
      let
        _moduleAttrs = classifyModules (attrByPath [ "modules" ] [] value) [name];
        _nixosModules_user = _moduleAttrs.nixosModules;
        _homeModules_user = _moduleAttrs.homeModules;
      in {
        _enableHomeManager = acc._enableHomeManager || (_homeModules_user != []);
        modules = acc.modules ++ _nixosModules_user ++ [({ ... }: {
          home-manager.users.${name}.imports = _homeModules_user;
        })];
      }
    ) { _enableHomeManager = false; modules = []; } users;
in {
  enableHomeManager = _enableHomeManager || specificUserModules._enableHomeManager;
  modules = nixosModules ++ [({ ... }: {
    home-manager = {
      sharedModules = sharedHomeModules;
      users = foldr (n: acc: acc // { "${n}" = {}; }) {} localUsers;
    };
  })] ++ specificUserModules.modules;
}
