{ util, lib, pkgs, ... }:
let
  wc = util.wrapWC pkgs "kcminputrc";
in {
  home.activation.setupInput = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${wc "Keyboard" "NumLock" "0"}
    ${wc "Mouse" "X11LibInputXAccelProfileFlat" "false"}
    ${wc "Mouse" "XLbInptAccelProfileFlat" "true"}
  '';
}