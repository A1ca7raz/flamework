{ tools, ... }:
with tools; {
  imports = foldGetFile ./. []
    (x: y:
      if isNix x
      then [ ./${x} ] ++ y
      else y
    );
}