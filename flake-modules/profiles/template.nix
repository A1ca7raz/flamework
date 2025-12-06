{ lib, config, name, ... }@args:
let
  inherit (lib)
    mkOption
    mkEnableOption
    types
    attrNames
    unique
    mkDefault
    any
    hasAttrByPath
    toLower
  ;
in {
  options = {
    targetHost = mkOption {
      type = with types; nullOr str;
      default = null;
      description = "Address of the target host, necessary for remote deploy.";
    };

    targetPort = mkOption {
      type = types.number;
      default = 22;
      description = "SSH Port of the target host.";
    };

    targetUser = mkOption {
      type = types.str;
      default = "root";
      description = "Target user of the target host.";
    };

    hostName = mkOption {
      type = types.str;
      description = "Hostname of the target host.";
    };

    tags = mkOption {
      type = with types; listOf str;
      default = [];
      description = "Tags of the target host.";
    };

    deployAsRoot = mkEnableOption "Use ROOT user instead target user for colmena deployment";

    allowLocalDeployment = mkEnableOption "Allow the configuration to be applied locally on the host running Colmena.";

    buildOnTarget = mkEnableOption "Whether to build the system profiles on the target node itself.";

    system = mkOption {
      type = types.str;
      default = "x86_64-linux";
      description = "System of the target host.";
    };

    modules = mkOption {
      type = with types; listOf raw;
      default = [];
      description = "Modules added to nixosConfiguration.";
    };

    users = mkOption {
      type = with types; attrsOf (listOf raw);
      default = {};
      description = "Per-User NixOS Modules.";
    };

    enableHomeManager = mkEnableOption "Enable Home Manager for this profile.";

    args = mkOption {
      type = types.attrs;
      default = {};
      description = "Extra arguments passed to nixosSystem";
    };

    _localUsers = mkOption {
      type = with types; listOf str;
      visible = false;
      readOnly = true;
    };

    _realTargetHost = mkOption {
      type = with types; nullOr str;
      visible = false;
      readOnly = true;
    };
  };

  config = {
    _localUsers =
      if config.targetUser == "root"
      then attrNames config.users
      else unique (attrNames config.users ++ [ config.targetUser ]);

    allowLocalDeployment =
      if any (t: t == "local") config.tags
      then mkDefault true
      else mkDefault false;

    _realTargetHost =
      if (toLower config.targetHost) == "redacted" && hasAttrByPath ["variables" "redact" name "targetHost"] args
      then args.variables.redact."${name}".targetHost
      else config.targetHost;
  };
}
