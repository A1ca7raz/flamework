{ lib, path, self, ... }:
let
  inherit (lib)
    evalModules

    # My func
    foldGetFile
    foldGetDir
    removeNix
  ;

  # cfg = config.flamework.profiles;
  profilePath = /${path}/profiles;
  presetPath = /${profilePath}/__templates;

  baseModule = import ./template.nix;

  wrapProfile = profile:
  (evalModules {
    modules = [
      baseModule
      profile
    ];

    specialArgs = {
      inherit self;
      templates = foldGetFile
        presetPath
        {}
        (x: y: { "${removeNix x}" = /${presetPath}/${x}; } // y );
    };
  }).config;
in
foldGetDir
  profilePath
  {}
  (x: y:
    if x != "__templates"
    then {
      "${x}" = wrapProfile /${profilePath}/${x};
    } // y
    else y
  )
# in {
#   flamework.profiles._profiles = foldGetDir
#     profilePath
#     {}
#     (x: y:
#       {
#         "${x}" = wrapProfile ./${profilePath}/${x};
#       } // y
#     );
# }
