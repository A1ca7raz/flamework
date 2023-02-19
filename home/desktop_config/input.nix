{ util, lib, ... }:
let
  wc = util.wc "kcminputrc";
in
{
  home.activation.setupInput = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${wc "Keyboard" "NumLock" "0"}
    ${wc "Mouse" "X11LibInputXAccelProfileFlat" "false"}
    ${wc "Mouse" "XLbInptAccelProfileFlat" "true"}
  '';
}