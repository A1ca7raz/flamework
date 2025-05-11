lib:
path:
let
  inherit (lib)
    foldGetFile
    isNix
    recursiveUpdate
  ;
in
foldGetFile
  path
  {}
  (x: y:
    if isNix x
    then recursiveUpdate y (scopedImport { inherit lib; } /${path}/${x})
    else y
  )
