{ util, lib, self, path, options, config, ... }:
with lib; let
  cfg = config.utils.homeModules;

  home_path = /${path}/home;
  home_extra_module_path = /${path}/modules/home-modules;
  home_module_list = util.foldGetFile home_path [] (x: y:
    if util.isNix x
    then [ (util.removeNix x) ] ++ y else y
  );

  mergeHomeModuleList = name: optional:
    let 
      _common_global_list = util.foldFileIfExists /${home_path}/__common [] (x: y:
        if util.isNix x
        then [ /${home_path}/__common/${x} ] ++ y else y
      );

      _common_user_list = util.foldFileIfExists /${home_path}/_${name} [] (x: y:
        if util.isNix x
        then [ /${home_path}/_${name}/${x} ] ++ y else y
      );

    in [] ++ _common_global_list ++ _common_user_list ++ (
      fold (x: y: [ /${home_path}/${x}.nix ] ++ y) [] optional
    );

  mkUserProfiles = mapAttrs 
    (n: v: { imports = mergeHomeModuleList n v; })
    cfg;

in {
  imports = [ self.nixosModules.home ];

  options.utils.homeModules = mkOption {
    type = with types; nullOr (attrsOf (listOf (enum home_module_list)));
    default = null;
    description = "Home-Manager Modules";
  };

  config.home-manager = mkIf (!isNull cfg) {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ self.inputs.sops-nix.homeManagerModule ] ++
      (util.importsFiles /${path}/utils/home);
    extraSpecialArgs = { inherit util self path; inputs = self.inputs; };
    users = mkUserProfiles;
  };
}