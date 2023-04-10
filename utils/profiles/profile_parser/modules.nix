{ util, lib, self, path, inputs, constant, ... }@args: modules:
with lib; let
  isHomeModule = x: with builtins; any (x: x == "home") (attrNames (functionArgs x));

  _parser = value:
    if builtins.isFunction value
    then value
    else if builtins.isAttrs value && value != {}
    then _recur value
    else null;

  _recur = mapAttrsToList (name: _parser);

  _get_module_set = list: flatten (forEach list (elem:
    if builtins.isFunction elem
    then elem
    else if builtins.isAttrs elem && elem != {}
    then _recur elem
    else null
  ));

  _filter_nixos_module = with builtins; concatMap (x:
    if ! isHomeModule x && (attrNames (functionArgs x)) != [ "user" ]
    then [] else [x]
  );

  _filter_specific_nixos_module = user: set:
    forEach user (x:
      { ... }: rec {
        imports = (
          builtins.concatMap (x:
            if ! isHomeModule x && (attrNames (functionArgs x)) == [ "user" ]
            then [ (util.try_func (x { inherit user; })) ]
            else [];
          ) set
        );
      }
    );

  _filter_home_module = user: set:
    forEach user (x:
      { ... }: rec {
        home-manager.users.${x}.imports = (
          builtins.concatMap (x:
            if isHomeModule x
            then [x] else []
          ) set
        );
      }
    );

  module_set = remove null (_get_module_set modules.use);
  nixosModules = _filter_nixos_module module_set;
  specialNixosModules = _filter_specific_nixos_module modules.homeUsers module_set;
  commonHomeModules = _filter_home_module modules.homeUsers module_set;

  specialUserModules = mapAttrsToList (name: value:
    let
      _modules = _get_module_set value;
      _nixosModules = _filter_nixos_module _modules;
      _specific_nixosModules = _filter_specific_nixos_module [ name ] _modules;
      _homeModules = _filter_home_module [ name ] _modules;
    in
    { ... }: rec {
      imports = _nixosModules ++ _specific_nixosModules;
      home-manager.users.${name}.imports = _homeModules;
    }
  ) modules.users;
in
  nixosModules ++ specialNixosModules ++ commonHomeModules ++ specialUserModules;
