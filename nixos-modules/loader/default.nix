{ lib, ... }:
with lib; {
  imports = foldGetFile ./. []
    (x: y:
      if isNix x
      then [ ./${x} ] ++ y
      else y
    );
}