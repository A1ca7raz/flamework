{ util, lib, self, path, inputs, constant, ... }@args:
let
  tpl_path = /${path}/profiles/__templates;
  tpl_list = util._getListFromDir "nix" tpl_path;

  mergeDefault = src: pathstr: value:
    let
      path = lib.splitString "." pathstr;
    in
      lib.attrByPath path value src;

  mkTplWrapper = tpl:
    let
      name = util.removeNix tpl;
      tpl_content = import /${tpl_path}/${tpl} args;

      _merge = mergeDefault tpl_content;
    in rec {
      ${name} = let
        component_default = util.try_bool (_merge "components.groups.useDefault" true);
        component_grps = util.try_list (_merge "components.groups.use" []);
        module_default = util.try_bool (_merge "modules.groups.useDefault" true);
        module_grps = util.try_list (_merge "modules.groups.use" []);

        trivial = lib.recursiveUpdate {
          system = "x86_64-linux";
          targetHost = "127.0.0.1";
          targetPort = 22;
          targetUser = "root";
          components.groups.use = [];
          components.groups.useDefault = true;
          components.use = [];
          modules.groups.use = [];
          modules.groups.useDefault = true;
          modules.use = [];
          modules.users = {};
          modules.extraUsers = [];
          extraConfiguration = {};
        } tpl_content;
      in {
        groups = {
          component = if component_default then component_grps ++ ["./"] else component_grps;
          module = if module_default then module_grps ++ ["./"] else module_grps;
        };

        mkProfile = { components, modules }: c:
          let
            _merge_c = mergeDefault c;
            content_from_tpl = lib.recursiveUpdate trivial c;

            base = {
              components = lib.forEach (util.try_list (_merge "components.use" [])) (x: components.${x});
              modules = lib.forEach (util.try_list (_merge "modules.use" [])) (x: modules.${x});
              extraModule = _merge "extraConfiguration" ({...}:{});
            };
            content = {
              components = util.try_list (_merge_c "components.use" []);
              modules = util.try_list (_merge_c "modules.use" []);
              userModules = util.try_attrs (_merge_c "modules.users" {});
              extraModule = _merge_c "extraConfiguration" ({...}:{});
            };
          in lib.recursiveUpdate content_from_tpl {
            components.use = base.components ++ content.components;
            modules.use = base.modules ++ content.modules ++ [ base.extraModule content.extraModule ];
            modules.homeUsers = content_from_tpl.modules.extraUsers ++ [ content_from_tpl.targetUser ];
            modules.users = lib.recursiveUpdate content_from_tpl.modules.users content.userModules;
          };
      };
    };
in
  lib.fold (x: y: (mkTplWrapper x) // y) {} tpl_list