{ util, lib, pkgs, ... }:
let
  wc = util.wrapWC pkgs "kcminputrc";
  wc_ = util.wrapWC_ pkgs "$HOME/.config/kcminputrc";
  wctouchpad = wc_ ["Libinput" "1739" "52781" "MSFT0004:00 06CB:CE2D Touchpad"];
  wcmouse = x: wc_ (["Libinput"] ++ x) "PointerAccelerationProfile" "1";
in {
  home.activation.setupInput = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${wc "Keyboard" "NumLock" "0"}
    ${wc "Mouse" "X11LibInputXAccelProfileFlat" "false"}
    ${wc "Mouse" "XLbInptAccelProfileFlat" "true"}
    ${wcmouse ["1133" "16505" "Logitech G Pro "]}
    ${wcmouse ["1133" "16500" "Logitech G304"]}
    ${wctouchpad "ClickMethod" "2"}
    ${wctouchpad "NaturalScroll" "true"}
    ${wctouchpad "TapToClick" "true"}
  '';
}