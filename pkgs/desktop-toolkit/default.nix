{
  lib,
  buildEnv,
  callPackage
}:
buildEnv (rec {
  name = "desktop-toolkit";
  paths = builtins.attrValues passthru;

  passthru = lib.foldGetDir ./. {}
    (pkg: acc:
      acc // { "${pkg}" = callPackage (import ./${pkg}) { inherit lib; } ; }
    );
})
