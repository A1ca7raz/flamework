{ util, lib, self, path, inputs, constant, ... }@args:
let
  tpl_path = /${path}/profiles/__templates;
  tpl_list = util._getListFromDir "nix" profile_path;

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

        trivial = ({
          targetPort ? 22,
          targetUser ? "root",
          system ? "x86_64-linux",
          ...
        }: { inherit targetPort targetUser system; }) tpl_content;
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
              modules = util.try_list (_merge_c "modules.use" []);;
              extraModule = _merge_c "extraConfiguration" ({...}:{});
            };
          in lib.recursiveUpdate content_from_tpl {
            components.use = base.components ++ content.components;
            modules.use = base.modules ++ content.modules ++ [ base.extraModule content.extraModule ];
            modules.homeUsers = content_from_tpl.modules.extraUsers ++ content_from_tpl.targetUser;
          };
      };
    };
in {
  templates = lib.forEach tpl_list (x: mkTplWrapper x);
}