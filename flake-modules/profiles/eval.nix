{ lib, config, self, ... }:
let
  inherit (lib)
    evalModules

    # My func
    foldGetFile
    foldGetDir
    removeNix
  ;

  cfg = config.flamework.profiles;
  # profilePath = /${path}/profiles;
  # presetPath = /${profilePath}/__templates;
  inherit (cfg)
    extraSpecialArgs
    profilesPath
    presetsPath
  ;

  base = import ./template.nix;

  wrapProfile = profile:
  (evalModules {
    modules = [
      base
      profile
    ];

    specialArgs = {
      inherit self;
      templates = foldGetFile
        presetsPath
        {}
        (x: y: { "${removeNix x}" = /${presetsPath}/${x}; } // y );
    } // extraSpecialArgs;
  }).config;
in {
  flamework.profiles._profiles = foldGetDir
    profilesPath
    {}
    (x: y:
      {
        "${x}" = wrapProfile /${profilesPath}/${x};
      } // y
    );
}
