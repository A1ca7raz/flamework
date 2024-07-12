lib:
with lib; with builtins;
let
  inherit (import ./module_verifier.nix lib)
    isHomeModule
    isHomeModuleUser
    isNixosModule
    isNixosModuleUser
    isHybridModule
    isModuleSet;
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
        if isNixosModule mod
        then acc // { nixosModules = acc.nixosModules ++ [ mod ]; }
        else if isNixosModuleUser mod
        then acc // { nixosModules = acc.nixosModules ++ wrapNixosModulesUser mod; }
        else if isHomeModule mod
        then acc // { homeModules = acc.homeModules ++ [ (wrapHomeModule mod) ]; }
        else if isHybridModule mod
        then
          let
            mods = parseHybridModule mod;
          in {
            nixosModules = acc.nixosModules ++ mods.nixosModules;
            homeModules = acc.homeModules ++ mods.homeModules;
          }
        else if isModuleSet mod
        then _recur acc (filterModuleSet mod)
        else acc;
      _recur = foldr _parser;
    in
      foldr _parser initModuleSet mods;
}