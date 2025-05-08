{ config, lib, self, inputs, ... }:
let
  inherit (lib)
    importsFiles
    recursiveUpdate
    genAttrs
    extend
    optionals
    foldlAttrs
    nixosSystem
  ;

  cfg = config.flamework.profiles;

  profiles = cfg._profiles;
  profile_path = cfg.profilesPath;

  module_parser = import ./modules.nix lib;

  homeModulesPath = ./../../home-modules;

  mkSystem = name: {
    system,
    modules ? [],
    users ? {},
    targetUser ? "root",
    hostName ? null,
    tags ? [],
    args ? {},
    ...
  }@profile:
    let
      module_parsed = module_parser { inherit modules users targetUser; };

      # NOTE: rename var to const
      # NOTE: rename var.host to const.node
      const = recursiveUpdate (import ./constant.nix lib cfg.constantsPath) {
        node = args // {
          inherit hostName;
          profileName = name;
          tags = genAttrs tags (x: x);
        };
      };

      specialArgs = { inherit self inputs const; } // cfg.extraSpecialArgs;

      lib = extend (final: prev: {
        utils = import ./../../lib/constants { inherit lib const; };
      });
    in {
      inherit system specialArgs lib;
      modules = [
        self.nixosModules.utils
        self.nixosModules.impermanence
        self.nixosModules.home
        self.nixosModules.nur
        /${profile_path}/${name}/hardware-configuration.nix
        # Enable Home Manager
        (optionals module_parsed.enableHomeManager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [ self.homeModules.sops ] ++ (importsFiles homeModulesPath);
              extraSpecialArgs = specialArgs;
            };
        })
      ] ++ module_parsed.modules
        # Automatically load node secrets
        ++ optionals (builtins.pathExists /${profile_path}/${name}/secrets.yml) [
          {
            sops.defaultSopsFile = /${profile_path}/${name}/secrets.yml;
          }
          (optionals module_parsed.enableHomeManager
            {
              home-manager.sharedModules = [{
                sops.defaultSopsFile = /${profile_path}/${name}/secrets.yml;
              }];
            }
          )
        ]
        # Enable Colmena Hive
        ++ optionals cfg.enableColmenaHive [
          self.nixosModules.colmena
          {
            deployment = {
              inherit (profile)
                targetHost
                targetPort
                targetUser
                tags
                allowLocalDeployment
                buildOnTarget
              ;
            };
          }
        ];
    };
in {
  imports = [
    ./options.nix
    ./eval.nix
    ./colmena.nix
  ];

  flake.nixosConfigurations = foldlAttrs
    (acc: n: v:
      acc // {
        "${n}" = nixosSystem (mkSystem n v);
      }
    ) {} profiles;
}
