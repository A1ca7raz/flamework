{ lib, ... }:
let
  inherit (lib)
    foldGetFile
    isNix
  ;
in {
  imports = foldGetFile ./. []
    (x: y:
      if isNix x
      then [ ./${x} ] ++ y
      else y
    );
}
