{ lib, var }@args:
with lib;
foldGetFile ./. {}
  (x: y:
    if isNix x
    then (import ./${x} args) // y
    else y
  )