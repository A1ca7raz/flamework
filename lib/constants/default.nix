{ lib, ... }@args:
let
  inherit (lib)
    foldGetFile
    isNix
  ;
in
foldGetFile ./. {}
  (x: y:
    if isNix x
    then (import ./${x} args) // y
    else y
  )
