{ util, lib, self, path, ... }:
let
  RESERVED_WORDS = [ "default.nix" "default" ];

  component_path = /${path}/components;
  profile_path = /${path}/profiles;

  DEFAULT_MODULES = lib.forEach ((import /${path}/modules)).defaultModules (x: self.nixosModules.${x});

  profile_list = util._getListFromDir "directory" profile_path;

  colmenaMeta = {
    meta = {
      nixpkgs = import self.inputs.nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
      specialArgs = { inherit util path self; };
    };
  };

  mkSystem = name: {
    system ? "x86_64-linux",
    activeModules ? [],
    components ? {},
    extraConfiguration ? {},
    ... 
  }:
    let
      components_common = util.foldGetFile /${component_path}/__common [] (x: y:
          if util.isNix x
          then [ (util.removeNix x) ] ++ y else y
        );
      components_optional = util.foldGetFile component_path [] (x: y:
          if util.isNix x
          then [ (util.removeNix x) ] ++ y else y
        );

      # Input Validation
      _blacklist = (x:
        assert lib.assertMsg ((lib.intersectLists components_common x) == x)
          "Non-existent component in blacklist.\nCheck the component blacklist of Profile ${name} and try again";
        lib.subtractLists x components_common)
        (lib.attrByPath ["blacklist"] [] components);

      _optionalComponents = (x:
        assert lib.assertMsg ((lib.intersectLists components_optional x) == x)
          "Non-existent component in optionalComponents.\nCheck the component blacklist of Profile ${name} and try again";
        x)
        (lib.attrByPath ["optionalComponents"] [] components);
    in {
      inherit system;
      specialArgs = { inherit util path self; };
      modules = DEFAULT_MODULES ++ activeModules ++
        (lib.forEach _blacklist (x: /${component_path}/__common/${x}.nix ) ) ++
        (lib.forEach _optionalComponents (x: /${component_path}/${x}.nix ) ) ++
        [
          self.nixosModules.utils
          /${profile_path}/${name}/hardware-configuration.nix
          extraConfiguration
          ({ ... }: lib.mkIf (builtins.pathExists /${profile_path}/${name}/secrets.yaml) {
            sops.secrets."__profile__" = {
              sopsFile = /${profile_path}/${name}/secrets.yaml;
              format = "yaml";
            };
          })
        ];
    };
in
  lib.fold (x: y:
    rec {
      nixosConfigurations = { ${x.name} = lib.nixosSystem x.nixosSystem; } // y.nixosConfigurations;
      colmena = { ${x.name} = { deployment = x.deployment; imports = x.modules; }; } // y.colmena;
    }) { nixosConfigurations = {}; colmena = colmenaMeta; }
    (lib.fold (x: y: [ ((z: rec {
        name = x;
        nixosSystem = mkSystem x z;
        modules = nixosSystem.modules;
        deployment = {
          targetHost = z.targetHost;
          targetPort = z.targetPort;
          targetUser = "root";
        };
      }) ((import /${profile_path}/${x}) {inherit self;})) ] ++ y) [] profile_list)