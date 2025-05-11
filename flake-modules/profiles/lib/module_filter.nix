lib:
let
  inherit (builtins)
    attrValues
    isPath
  ;

  inherit (lib)
    forEach
    filterAttrs
    hasPrefix
    foldr
  ;

  inherit (import ./module_verifier.nix lib)
    isHomeModule
    # isHomeModuleUser
    isNixosModule
    isNixosModuleUser
    isHybridModule
    isModuleSet
    isCompatibleNixosModule
  ;
in {
  classifyModules = mods: users:
    let
      initModuleSet = { nixosModules = []; homeModules = []; };

      wrapNixosModulesUser = module:
        let
          wrapper = user: args@{ pkgs, ... }: module (args // { inherit user; });
        in
          forEach users (u: wrapper u);

      wrapHomeModule = module: args@{ pkgs, ... }: module (args // { home = null; });

      parseHybridModule = mods:
        let
          nixosModules =
            if mods ? nixosModule
            then
              if isNixosModuleUser mods.nixosModule
              then wrapNixosModulesUser mods.nixosModule
              else [ mods.nixosModule ]
            else [];
          homeModules =  (
            if mods ? homeModule
            then [ mods.homeModule ]
            else []);
        in {
          inherit nixosModules homeModules;
        };

      filterModuleSet = set: attrValues (filterAttrs (n: v: n != "exclude" && ! hasPrefix "_" n) set);

      _parser = mod: acc:
        let
          _mod = if isPath mod then import mod else mod;
        in
          if isNixosModule _mod
          then acc // { nixosModules = acc.nixosModules ++ [ _mod ]; }
          else if isNixosModuleUser _mod
          then acc // { nixosModules = acc.nixosModules ++ wrapNixosModulesUser _mod; }
          else if isHomeModule _mod
          then acc // { homeModules = acc.homeModules ++ [ (wrapHomeModule _mod) ]; }
          else if isHybridModule _mod
          then
            let
              mods = parseHybridModule _mod;
            in {
              nixosModules = acc.nixosModules ++ mods.nixosModules;
              homeModules = acc.homeModules ++ mods.homeModules;
            }
          else if isModuleSet _mod
          then _recur acc (filterModuleSet _mod)
          else if isCompatibleNixosModule _mod
          then acc // { nixosModules = acc.nixosModules ++ [ _mod ]; }
          else acc;
      _recur = foldr _parser;
    in
      foldr _parser initModuleSet mods;
}
