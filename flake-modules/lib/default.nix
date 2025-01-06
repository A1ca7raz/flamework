lib:
lib.extend (
  final: prev:
  let
    inherit (import ./fold.nix lib) foldGetFile;

    inherit (lib)
      hasSuffix
    ;
  in
  foldGetFile ./. {}
    (x: y:
      if hasSuffix ".nix" x
      then (import ./${x} lib) // y
      else y
    )
)
