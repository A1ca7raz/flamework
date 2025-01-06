lib:
path:
with lib;
foldGetFile
  path
  {}
  (x: y:
    if isNix x
    then recursiveUpdate y (scopedImport { inherit lib; } /${path}/${x})
    else y
  )
