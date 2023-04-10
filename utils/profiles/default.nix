{ util, lib, self, path, inputs, constant, ... }@args:
with lib; let
  _inc = ./profile_parser;

  component_path = /${path}/components;
  componentTree = util.mkModuleTreeFromFiles component_path;
  module_path = /${path}/modules;
  moduleTree = util.mkModuleTreeFromDirs module_path;

  # hook: args: profile:
  attrsHooks = util.importsFiles /${_inc}/attrsets;
  mergeLoaderHooks = profile:
    let
      hooks = forEach attrsHooks (x: (import x) args profile);
    in
      zipAttrsWith
        (name: vals: fold (x: y: recursiveUpdate x y) {} vals)
        hooks;

  profile_path = /${path}/profiles;
  profile_list = remove "__templates" (util._getListFromDir "directory" profile_path);

  template_set = import /${_inc}/templates.nix args;
  passthruTpl = profile:
    let
      profile_args = with builtins; attrNames (functionArgs profile);
      tpl_name = util.throwIfNot (x: (count (y: true) x) <= 1)
        "At most one template is expected."
        (subtractLists (args ++ ["components" "modules"]) profile_args);
      tpl = template_set.${tpl_name};

      component_grp_content = fold (x: y: recursiveUpdate y (util.mkModuleTreeFromFiles /${component_path}/${x})) {} tpl.groups.component;
      module_grp_content = fold (x: y: recursiveUpdate y (util.mkModuleTreeFromDirs /${module_path}/${x})) {} tpl.groups.module;
    in
      profile (rec {
        components = recursiveUpdate componentTree component_grp_content;
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
  }@profile:
    let
      profile_args = profile // { inherit name; };
      component_parser = import /${_inc}/components.nix args;
      module_parser = import /${_inc}/modules.nix args;
    in {
      inherit system;
      specialArgs = { inherit util self path inputs constant; };
      modules = [
        self.nixosModules.utils
        /${profile_path}/${name}/hardware-configuration.nix
        ({ ... }: {
          imports = [ self.nixosModules.impermanence ];

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [ self.inputs.sops-nix.homeManagerModule ] ++
              (util.importsFiles /${path}/utils/home);
            extraSpecialArgs = { inherit util self path inputs constant; };
          };
        })
      ] ++ (component_parser components)
        ++ (module_parser modules);
    };

  _profiles = fold (x: y: 
    [(
      mergeLoaderHooks (
        (z: rec {
          name = x;
          nixosSystem = mkSystem x z;
          modules = nixosSystem.modules;
          deployment = { inherit (z) targetHost targetPort targetUser; };
        })
        (passthruTpl (import /${profile_path}/${x}))
      )
    )] ++ y) [] profile_list;
in
  foldAttrs (n: a: n // a) {} _profiles