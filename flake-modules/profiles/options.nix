{ lib, ... }:
let
  inherit (lib)
    mkOption
    mkEnableOption
    types
  ;
in {
  options.flamework.profiles = {
    profilesPath = mkOption {
      type = types.path;
      description = "Path of profiles.";
    };

    presetsPath = mkOption {
      type = types.path;
      description = "Path of templates.";
    };

    constantsPath = mkOption {
      type = with types; either bool path;
      default = false;
      description = "Path of constants";
    };

    enableHomeManager = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Home Manager for all profiles by default.";
    };

    enableColmenaHive = mkEnableOption "Enable ColmenaHive for remote deployment.";

    extraSpecialArgs = mkOption {
      type = types.attrs;
      default = {};
      description = "Extra arguments passed to nixosSystem.";
    };

    _profiles = mkOption {
      type = types.attrs;
      visible = false;
      readOnly = true;
    };
  };
}
