{ lib, self, path, inputs, ... }@args:
with lib; let
  # module处理器
  module_parser = import ./modules.nix args;

  profile_path = /${path}/profiles;
  profiles = import ./eval.nix args;

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
    modules ? [],
    users ? {},
    targetUser ? "root",
    hostName ? null,
    tags ? [],
    args ? {},
    ...
  }:
    let
      module_parsed = module_parser { inherit modules users targetUser; };

      var = recursiveUpdate (import ./../constant.nix lib) {
        host = args // {
          inherit hostName;
          tags = genAttrs tags (x: x);
        };
      };

      specialArgs = { inherit self path inputs var; };

      lib = extend(final: prev: {
        utils = import ./../lib/var { inherit lib var; };
      });
    in {
      inherit system specialArgs lib;
      modules = [
        self.nixosModules.utils
        self.nixosModules.impermanence
        self.nixosModules.home
        self.nixosModules.nur
        /${profile_path}/${name}/hardware-configuration.nix
        # automatically disable home-manager
        (optionals module_parsed.enableHomeManager (
          { ... }: {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [ inputs.sops-nix.homeManagerModule ] ++ (importsFiles /${path}/utils/home);
              extraSpecialArgs = specialArgs;
            };
          }
        ))
      ] ++ module_parsed.modules
        ++ optionals (builtins.pathExists /${profile_path}/${name}/secrets.yml) [
          ({ ... }: {
            sops.defaultSopsFile = /${profile_path}/${name}/secrets.yml;
          })
          (optionals module_parsed.enableHomeManager (
            { ... }: {
              home-manager.sharedModules = [
                ({ ... }: {
                  sops.defaultSopsFile = /${profile_path}/${name}/secrets.yml;
                })
              ];
            }
          ))
        ];
    };

  _profiles = foldlAttrs
    (acc: n: v:
      [(
        mergeLoaderHooks (
          rec {
            name = n;
            inherit (v) system;
            nixosSystem = mkSystem n v;
            modules = nixosSystem.modules;
            deployment = { inherit (v) targetHost targetPort targetUser; };
          }
        )
      )] ++ acc
    ) [] profiles;
in
  foldAttrs (n: a: n // a) {} _profiles
