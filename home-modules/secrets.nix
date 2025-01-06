{ lib, config, ... }:
with lib; let
  cfg = config.utils.secrets;

  secretType = types.submodule (
    { name, config, ... }: {
      options = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable the secret file";
        };

        path = mkOption {
          type = with types; nullOr path;
          default = null;
          description = ''
            Sops file the secret is loaded from.
          '';
        };
      };
    }
  );
in {
  options.utils.secrets = mkOption {
    type = with types; attrsOf secretType;
    default = {};
    description = "Attribute set of secrets to enable";
  };

  config = mkIf ((attrNames cfg) != []) {
    sops = {
      age = {
        keyFile = mkDefault "/var/lib/age.home.key";
        sshKeyPaths = mkDefault [];
        generateKey = mkDefault false;
      };
      gnupg.sshKeyPaths = mkDefault [];
      secrets = mapAttrs (name: value:
        if isNull value.path
        then {}
        else if builtins.pathExists value.path
        then {
          sopsFile = value.path;
        } // optionals (hasSuffix ".json" (toString value.path)) {
          format = "binary";
        }
        else throw "${value.path} does not exists."
      ) (filterAttrs (n: v: v.enable == true) cfg);
    };
  };
}