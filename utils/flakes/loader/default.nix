{ util, lib, self, path, ... }:
util.foldGetFile ./. {}
  (x: y:
    if util.isNix x
    then rec { ${util.removeNix x} = import ./${x} { inherit util self lib path; }; } // y
    else y
  )