{ lib, tools, ... }:
{
  imports = tools.importsFiles ./.;
  options.utils.gitea = lib.mkOption {
    default = {};
    type = lib.types.attrsOf lib.types.attrs;
  };
}