{ lib, ... }@args:
with lib; with builtins;
let
  util = import ./verify_type.nix args;
in rec {
  isHomeModule = x: isFunction x && ! mutuallyExclusive ["home"] (attrNames (functionArgs x));
  isNormalNixosModule = x: isFunction x && mutuallyExclusive ["user" "home"] (attrNames (functionArgs x));
  isSpecialNixosModule = x: isFunction x && ! mutuallyExclusive ["user"] (attrNames (functionArgs x));
  isHybridModule = x: isAttrs x && (attrNames x) == ["homeModule" "nixosModule"];

  getModuleList = list:
  let
    _parser = value:
      if isFunction value
      then value
      else if isHybridModule value
      then
        let
          wrapHomeModule = module: other@{ home, ... }: module other;
        in
          [ value.nixosModule (wrapHomeModule value.homeModule) ]
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
            wrapHomeModule = module: other@{ home, ... }: module other;
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
  let
    wrapper = user: module: other@{ pkgs, ... }: module (other // { inherit user; });
  in
    concatMap
      (user:
        concatMap
          (x:
            if isSpecialNixosModule x
            then [(wrapper user x)]
            else []
          ) modules
      ) users;

  # modules with 'home' args (homeModule)
  filterHomeModules = users: modules:
  let
    wrapper = module: other@{ pkgs, ... }: module (other // { home = null; });
    _filtered = concatMap
      (x:
        if isHomeModule x
        then [(wrapper x)] else []
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