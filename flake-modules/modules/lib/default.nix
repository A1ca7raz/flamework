lib:
let
  inherit (builtins)
    foldl'
    filter
    attrNames
    readDir
  ;
in
foldl'
  (acc: f:
    acc //
    (import ./${f} lib)
  )
  {}
  (
    filter
      (f: f != "default.nix")
      (attrNames (readDir ./.))
  )
