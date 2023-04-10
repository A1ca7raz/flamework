{ util, lib, self, path, inputs, constant, ... }@args: modules:
with lib; let
  isHomeModule = x: with builtins; ! lib.mutuallyExclusive ["home"] (attrNames (functionArgs x));
  isNormalNixosModule = x: with builtins; lib.mutuallyExclusive ["user" "home"] (attrNames (functionArgs x));
  isSpecialNixosModule = x: with builtins;
    (attrNames (functionArgs x)) == ["user"];

  _parser = value:
    if builtins.isFunction value
    then value
    else if builtins.isAttrs value && value != {}
    then _recur value
    else null;

  _recur = mapAttrsToList (name: _parser);

  _get_module_list = list: flatten (concatMap (elem:
    if builtins.isFunction elem
    then [ elem ]
    else if builtins.isAttrs elem && elem != {}
    then [(_recur elem)]
    else []
  ) list);

  # modules without 'user' arg (nixosModule)
  _filter_nixos_module = with builtins; concatMap (x:
    if isNormalNixosModule x
    then [x] else []
  );

  # modules with 'user' arg (nixosModule with current username)
  _filter_special_nixos_module = users: modules:
    concatMap (user:
      builtins.concatMap (x:
        if isSpecialNixosModule x
        then [(util.try_func (x { inherit user; }))]
        else []
      ) modules
    ) users;

  # modules with 'home' args (homeModule)
  _filter_home_module = users: modules:
    let
      _filtered = builtins.concatMap (x:
        if isHomeModule x
        then [x] else []
      ) modules;
    in
      if _filtered == []
      then []
      else forEach users (user: { ... }: rec {
        home-manager.users.${user}.imports = _filtered;
      });

  module_list = _get_module_list modules.use;
  nixosModules = _filter_nixos_module module_list;
  specialNixosModules = _filter_special_nixos_module modules.homeUsers module_list;
  commonHomeModules = _filter_home_module modules.homeUsers module_list;

  specialUserModules = mapAttrsToList (name: value:
    let
      _modules = _get_module_list value;
      _nixosModules = _filter_nixos_module _modules;
      _specific_nixosModules = _filter_special_nixos_module [name] _modules;
      _homeModules = _filter_home_module [name] _modules;
    in
    { ... }: {
      imports = _nixosModules ++ _specific_nixosModules ++ _homeModules;
    }
  ) modules.users;
in
  nixosModules ++ specialNixosModules ++ commonHomeModules ++ specialUserModules
