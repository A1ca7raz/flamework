{ lib, path, ... }@args:
with lib; let
  tpl_path = /${path}/profiles/__templates;
  tpl_list = _getListFromDir "nix" tpl_path;

  blank_tpl = {
    system = "x86_64-linux";
    targetHost = "127.0.0.1";
    targetPort = 22;
    targetUser = "root";
    modules = [];
    users = {};
    tags = [];
    args = {};
    # extraConfig = {};
  };

  _mkTplWrapper = tpl: ctx:
    let
      updateKey = key: attrByPath [key] (attrByPath [key] (getAttrFromPath [key] blank_tpl) tpl) ctx;

      localUsers = unique ((optionals (tpl ? users) (attrNames tpl.users)) ++ (optionals (ctx ? users) (attrNames ctx.users)));
      mergeUsers = user: sum:
        let
          tpl_mods = attrByPath [ user "modules" ] [] tpl;
          ctx_mods = attrByPath [ user "modules" ] [] ctx;
        in {
          ${user}.modules = unique (tpl_mods ++ ctx_mods);
        } // sum;

    in {
      system = updateKey "system";
      targetHost = updateKey "targetHost";
      targetPort = updateKey "targetPort";
      targetUser = updateKey "targetUser";

      modules = (attrByPath ["modules"] [] ctx) ++ (attrByPath ["modules"] [] tpl)
        ++ (optional (tpl ? extraConfig) tpl.extraConfig) ++ (optional (ctx ? extraConfig) ctx.extraConfig);
      users = foldr mergeUsers {} localUsers;
      tags = unique ((attrByPath ["tags"] [] ctx) ++ (attrByPath ["tags"] [] tpl));
      args = recursiveUpdate (attrByPath ["args"] {} tpl) (attrByPath ["args"] {} ctx);
      # modules = trivial.modules ++ ctx_full.modules ++ [ trivial.extraConfig ctx_full.extraConfig ];
      # users = recursiveUpdate trivial.users ctx_full.users;
      "__isWrappedTpl__" = true;
    };

  mkTplWrapper = tpl:
    let
      name = removeNix tpl;
      tpl_content = import /${tpl_path}/${tpl} args;  # 模板正文
    in {
      ${name} = _mkTplWrapper tpl_content;
    };
in {
  blankTemplate = _mkTplWrapper blank_tpl;
  templates = fold (x: y: (mkTplWrapper x) // y) {} tpl_list;
}