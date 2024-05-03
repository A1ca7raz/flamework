final: prev:
let
  inherit (import ./fold.nix lib) foldGetFile;
in
foldGetFile ./. {}
  (x: y:
    if lib.hasSuffix ".nix" x
    then (import ./${x} lib) // y
    else y
  )