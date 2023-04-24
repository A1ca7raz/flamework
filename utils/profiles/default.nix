{ util, lib, self, path, inputs, constant, ... }@args:
with lib; let
  _inc = ./profile_parser;

  component_path = /${path}/components;
  componentTree = util.mkModuleTreeFromFiles component_path;
  module_path = /${path}/modules;
  moduleTree = util.mkModuleTreeFromDirs module_path;

  component_parser = import /${_inc}/components.nix args;
  module_parser = import /${_inc}/modules.nix args;

  components_common = 
    if hasAttrByPath ["__common"] componentTree
    then
      component_parser (attrValues componentTree.__common)
    else [];

  # hook: args: profile:
  attrsHooks = util.importsFiles /${_inc}/attrsets;
  mergeLoaderHooks = profile: let
    hooks = forEach attrsHooks (x: (import x) args profile);
  in
    zipAttrsWith (name: vals: fold (x: y: recursiveUpdate x y) {} vals) hooks;

  profile_path = /${path}/profiles;
  profile_list = remove "__templates" (util._getListFromDir "directory" profile_path);

  template_set = import /${_inc}/templates.nix args;
  passthruTpl = profile:
  with builtins; let
    profile_args = attrNames (functionArgs profile);
    tpl_list = util.test (x: (count (y: true) x) > 1)
      "At most one template is expected."
      (subtractLists (attrNames args ++ ["components" "modules"]) profile_args);
    blank_tpl = {
      system = "x86_64-linux";
      targetHost = "127.0.0.1";
      targetPort = 22;
      targetUser = "root";
      components.use = {};
      modules = {
        use = [];
        users = {};
        extraUsers = [];
      };
      extraConfiguration = null;
    };
    componentOptions = filterAttrs (n: v: n != "__common") componentTree;
  in
    if count (x: true) tpl_list == 0
    then
      let
        wrapNormalProfile = p: let
          _full = recursiveUpdate blank_tpl p;
        in recursiveUpdate _full {
          modules = {
            homeUsers = _full.modules.extraUsers ++ [ _full.targetUser ];
          } // (
            if isNull _full.extraConfiguration
            then {}
            else {
              use = _full.modules.use ++ [ _full.extraConfiguration ];
            }
          );
        };
      in
        wrapNormalProfile (profile ({ components = componentOptions; modules = moduleTree; } // args))
    else
      let
        tpl_name = elemAt tpl_list 0;
        tpl = template_set.${tpl_name};
        component_grp_content = fold (x: y: recursiveUpdate y (util.mkModuleTreeFromFiles /${component_path}/${x})) {} tpl.groups.component;
        module_grp_content = fold (x: y: recursiveUpdate y (util.mkModuleTreeFromDirs /${module_path}/${x})) {} tpl.groups.module;
      in
        profile (rec {
          components = recursiveUpdate componentOptions component_grp_content;
          modules = recursiveUpdate moduleTree module_grp_content;
          ${tpl_name} = tpl.mkProfile { inherit components modules; };
        } // args);

  mkSystem = name: {
    system,
    components ? {},
    # components.use
    modules ? {},
    # modules.homeUsers
    # modules.use
    # modules.users
    ...
  }@profile: let
    profile_args = profile // { inherit name; };
  in {
    inherit system;
    specialArgs = { inherit util self path inputs constant; };
    modules = [
      self.nixosModules.utils
      self.nixosModules.impermanence
      self.nixosModules.home
      /${profile_path}/${name}/hardware-configuration.nix
      ({ ... }: {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          sharedModules = [ self.inputs.sops-nix.homeManagerModule ] ++
            (util.importsFiles /${path}/utils/home);
          extraSpecialArgs = { inherit util self path inputs constant; };
        };
      })
    ] ++ (component_parser components.use)
      ++ (module_parser modules)
      ++ components_common;
  };

  _profiles = fold
    (x: y:
      [(
        mergeLoaderHooks (
          (z: rec {
            name = x;
            inherit (z) system;
            nixosSystem = mkSystem x z;
            modules = nixosSystem.modules;
            deployment = { inherit (z) targetHost targetPort targetUser; };
          })
          (passthruTpl (import /${profile_path}/${x}))
        )
      )] ++ y
    ) [] profile_list;
in
  foldAttrs (n: a: n // a) {} _profiles