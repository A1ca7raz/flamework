{ lib, self, path, inputs, tools, ... }@args:
with lib; with tools; let
  # module处理器
  module_parser = import ./modules.nix args;

  # 获取profile列表
  profile_path = /${path}/profiles;
  profile_list = remove "__templates" (_getListFromDir "directory" profile_path);

  # 处理模板
  inherit (import ./templates.nix args) templates blankTemplate; # 后处理模板集
  passthruTpl = profile:
    let
      wrapped = profile (templates // args);
    in
      if (hasAttrByPath [ "__isWrappedTpl__" ] wrapped)
      then wrapped
      else blankTemplate wrapped;

  # 处理profile钩子: 生成colmena和nixos config两种配置
  # hook: args: profile:
  attrsHooks = importsFiles ./attrhooks;
  mergeLoaderHooks = profile:
    let
      hooks = forEach attrsHooks (x: (import x) args profile);
    in
      zipAttrsWith (name: vals: fold (x: y: recursiveUpdate x y) {} vals) hooks;

  # 生成nixossystem
  mkSystem = name: {
    system,
    modules ? {},
    users ? {},
    targetUser ? "root",
    ...
  }: {
    inherit system;
    specialArgs = { inherit self path inputs tools; };
    modules = [
      self.nixosModules.utils
      self.nixosModules.impermanence
      self.nixosModules.home
      /${profile_path}/${name}/hardware-configuration.nix
      ({ ... }: {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          sharedModules = [
            self.inputs.sops-nix.homeManagerModule
          ] ++ (importsFiles /${path}/utils/home);
          extraSpecialArgs = { inherit self path inputs tools; };
        };
      })
    ] ++ (module_parser { inherit modules users targetUser; });
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