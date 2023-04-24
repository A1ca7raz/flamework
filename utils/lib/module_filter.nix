{ lib, ... }@args:
with lib; with builtins;
let
  util = import ./verify_type.nix args;
in rec {
  isHomeModule = x: isFunction x && ! mutuallyExclusive ["home"] (attrNames (functionArgs x));
  isNormalNixosModule = x: isFunction x && mutuallyExclusive ["user" "home"] (attrNames (functionArgs x));
  isSpecialNixosModule = x: isFunction x && (attrNames (functionArgs x)) == ["user"];
  isHybridModule = x: isAttrs x && (attrNames x) == ["homeModule" "nixosModule"];

  getModuleList = list:
  let
    _parser = value:
      if isFunction value
      then value
      else if isAttrs value && value != {}
      then _recur value
      else null;
    _recur = mapAttrsToList (name: _parser);
  in
    flatten (concatMap
      (elem:
        if isFunction elem
        then [ elem ]
        else if isHybridModule elem
        then
          let
            wrapHomeModule = module: { home, ... }@other: module other;
          in
            [ elem.nixosModule (wrapHomeModule elem.homeModule) ]
        else if isAttrs elem && elem != {}
        then [(_recur elem)]
        else []
      ) list
    );

  # modules without 'user' arg (nixosModule)
  filterNormalNixosModules = concatMap
    (x:
      if isNormalNixosModule x
      then [x] else []
    );

  # modules with 'user' arg (nixosModule with current username)
  filterSpecialNixosModules = users: modules:
    concatMap
      (user:
        concatMap
          (x:
            if isSpecialNixosModule x
            then [(util.try_func (x { inherit user; }))]
            else []
          ) modules
      ) users;

  # modules with 'home' args (homeModule)
  filterHomeModules = users: modules:
  let
    _filtered = concatMap
      (x:
        if isHomeModule x
        then [x] else []
      ) modules;
  in
    if _filtered == []
    then []
    else forEach users
      (user:
        { ... }: rec {
          home-manager.users.${user}.imports = _filtered;
        }
      );
}