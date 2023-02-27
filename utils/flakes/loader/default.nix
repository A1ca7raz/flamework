{ util, lib, self, path, inputs, ... }:
util.foldGetFile ./. {}
  (x: y:
    if util.isNix x
    then rec { ${util.removeNix x} = import ./${x} { inherit util self lib path inputs; }; } // y
    else y
  )