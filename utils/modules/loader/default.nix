{ util, lib, ... }:
{
  imports = util.foldGetFile ./. []
    (x: y:
      if util.isNix x
      then [ ./${x} ] ++ y
      else y
    );
}