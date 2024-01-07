lib:
with lib; with builtins;
let
  inherit (import ./module_verifier.nix lib)
    isHomeModule
    isNixosModule
    isNixosModuleUser
    isHybridModule
    isModuleSet;
in {

  getModuleList = list:
    let
      _parser = item:
        if isFunction item
        then item
        else if isHybridModule item
        then
          let
            wrapHomeModule = module: args@{ home, ... }: module args;
          in
            [ (optionalAttrs (item ? nixosModule) item.nixosModule) (optionalAttrs (item ? homeModule) (wrapHomeModule item.homeModule)) ]
        else if isModuleSet item
        then _recur (filterAttrs (n: v: n != "exclude") item)
        else null;
      _recur = mapAttrsToList (name: _parser);
    in
      flatten (concatMap
        (item:
          if isFunction item
          then [ item ]
          else if isHybridModule item
          then
            let
              wrapHomeModule = module: args@{ home, ... }: module args;
            in
              [ (optionalAttrs (item ? nixosModule) item.nixosModule) (optionalAttrs (item ? homeModule) (wrapHomeModule item.homeModule)) ]
          else if isModuleSet item
          then [(_recur (filterAttrs (n: v: n != "exclude") item))]
          else []
        ) list
      );

  # modules without 'user' arg (nixosModule)
  filterNixosModules = concatMap (x: if isNixosModule x then [x] else []);

  # modules with 'user' arg (nixosModule with current username)
  filterNixosModulesUser = users: modules:
    let
      wrapper = user: module: args@{ pkgs, ... }: module (args // { inherit user; });
    in
      concatMap
        (user:
          concatMap
            (x: if isNixosModuleUser x then [(wrapper user x)] else [])
            modules
        ) users;

  # modules with 'home' args (homeModule)
  filterHomeModules = users: modules:
    let
      wrapper = module: args@{ pkgs, ... }: module (args // { home = null; });
      _filtered = concatMap (x: if isHomeModule x then [(wrapper x)] else []) modules;
    in
      if _filtered == []
      then []
      else forEach users
        (user: { ... }: { home-manager.users.${user}.imports = _filtered; });
}