{ lib, path, tools, ... }@args:
with lib; with tools; let
  tpl_path = /${path}/profiles/__templates;
  tpl_list = _getListFromDir "nix" tpl_path;

  blank_tpl = {
    system = "x86_64-linux";
    targetHost = "127.0.0.1";
    targetPort = 22;
    targetUser = "root";
    modules = [];
    users = {};
    extraConfig = {};
  };

  _mkTplWrapper = tpl_content: ctx:
    with builtins; let
      trivial = recursiveUpdate blank_tpl tpl_content;  # 生成完整模板
      ctx_full = recursiveUpdate trivial ctx; # 覆盖模板内容
    in recursiveUpdate ctx_full { # merge模块
      modules = trivial.modules ++ ctx.modules ++ [ trivial.extraConfig ctx.extraConfig ];
      users = recursiveUpdate trivial.users ctx_full.users;
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