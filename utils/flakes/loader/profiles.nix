{ util, lib, self, path, inputs, ... }@args:
let
  # hook: args: profile:
  hook_stage1_list = util.importsFiles ./profile-hooks/01-stage-modules;
  hook_stage2_list = util.importsFiles ./profile-hooks/02-stage-rec;

  mergeModuleHooks = profile:
    let
      hooks = lib.forEach hook_stage1_list (x: ((import x) args profile));
    in
      lib.fold (x: y: x.modules ++ y) [] hooks;

  mergeLoaderHooks = profile:
    let
      hooks = lib.forEach hook_stage2_list (x: (import x) args profile);
    in
      lib.zipAttrsWith
        (name: vals: lib.fold (x: y: x // y) {} vals)
        hooks;

  RESERVED_WORDS = [ "default.nix" "default" ];

  profile_path = /${path}/profiles;
  profile_list = util._getListFromDir "directory" profile_path;

  mkSystem = name: {
    system ? "x86_64-linux",
    activeModules ? [],
    components ? {},
    extraConfiguration ? {},
    ... 
  }@profile:
    let
      profile_args = profile // { inherit name; };
    in {
      inherit system;
      specialArgs = { inherit util self path inputs; };
      modules = [
        self.nixosModules.utils
        /${profile_path}/${name}/hardware-configuration.nix
        extraConfiguration
      ] ++ (mergeModuleHooks profile_args);
    };

  _profiles = lib.fold (x: y: [ (mergeLoaderHooks (({targetHost ? "", targetPort ? 22, ...}@z: rec {
      name = x;
      nixosSystem = mkSystem x z;
      modules = nixosSystem.modules;
      deployment = {
        targetHost = targetHost;
        targetPort = targetPort;
        targetUser = "root";
      };
    }) ((import /${profile_path}/${x}) {inherit self;}))) ] ++ y) [] profile_list;
in
  lib.foldAttrs (n: a: n // a) {} _profiles

  # lib.fold (x: y:
  #   rec {
  #     nixosConfigurations = { ${x.name} = lib.nixosSystem x.nixosSystem; } // y.nixosConfigurations;
  #     colmena = { ${x.name} = { deployment = x.deployment; imports = x.modules; }; } // y.colmena;
  #   } // ) { nixosConfigurations = {}; colmena = colmenaMeta; }
  #   _profiles