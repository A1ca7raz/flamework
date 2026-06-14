{ lib, config, self, ... }:
let
  inherit (lib)
    evalModules

    # My func
    foldGetFile
    foldGetDir
    removeNix
  ;

  inherit (builtins)
    pathExists
  ;

  cfg = config.flamework.profiles;

  inherit (cfg)
    extraSpecialArgs
    profilesPath
    presetsPath
  ;

  validProfilesPath = if pathExists profilesPath
    then profilesPath
    else throw "flamework.profiles: profilesPath '${toString cfg.profilesPath}' does not exist.";

  validPresetsPath = if pathExists presetsPath
    then presetsPath
    else throw "flamework.profiles: presetsPath '${toString cfg.presetsPath}' does not exist.";

  base = import ./template.nix;

  wrapProfile = profile:
  (evalModules {
    modules = [
      base
      /${validProfilesPath}/${profile}
    ];

    specialArgs = {
      inherit self;
      name = profile;
      templates = foldGetFile
        validPresetsPath
        {}
        (x: y: { "${removeNix x}" = /${validPresetsPath}/${x}; } // y );
    } // extraSpecialArgs;
  }).config;
in {
  flamework.profiles._profiles = foldGetDir
    validProfilesPath
    {}
    (x: y:
      {
        "${x}" = wrapProfile x;
      } // y
    );
}
