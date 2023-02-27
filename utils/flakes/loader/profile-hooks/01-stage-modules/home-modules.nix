{ util, lib, self, path, inputs, ... }:
{
  name,
  system ? "x86_64-linux",
  activeModules ? [],
  components ? {},
  extraConfiguration ? {},
  homeModuleHelper ? null,
  ...
}:
if (lib.isAttrs homeModuleHelper) then 
  let
    # 这里的验证交给utils.homeModules，不存在的模块会由它报错。只需要做好对应nixos modules的映射
    # 所有的homeModules取并集，寻找对应的nixos modules
    home_modules = lib.unique (lib.flatten (lib.attrValues homeModuleHelper));

    extra_module_path = /${path}/modules/home-modules;
    home_system_modules = lib.remove null (lib.forEach home_modules (x:
      if builtins.pathExists /${extra_module_path}/${x}.nix
      then /${extra_module_path}/${x}.nix
      else null
    ));
  in {
    modules = [
      ({ ... }: {
        utils.homeModules = homeModuleHelper;
      })
    ] ++ home_system_modules;
  }
else if (isNull homeModuleHelper) then { modules = []; }
else abort "homeModuleHelper must be a Attrset."