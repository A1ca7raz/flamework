lib:
with lib;
foldGetFile
  ./../constant
  {}
  (x: y:
    if isNix x
    then recursiveUpdate y (scopedImport { inherit lib; } ./../constant/${x})
    else y
  )