{ tools, ... }:
with tools; let
  mk = mkRule "kcminputrc";
  mk_ = mkRule "kcminputrc";
  mktouchpad = mk_ ["Libinput" "1739" "52781" "MSFT0004:00 06CB:CE2D Touchpad"];
  mkmouse = x: mk_ (["Libinput"] ++ x) "PointerAccelerationProfile" "1";
in {
  utils.kconfig.rules = [
    (mk "Keyboard" "NumLock" "0")
    (mk "Mouse" "X11LibInputXAccelProfileFlat" "false")
    (mk "Mouse" "XLbInptAccelProfileFlat" "true")
    (mkmouse ["1133" "16505" "Logitech G Pro "])
    (mkmouse ["1133" "16500" "Logitech G304"])
    (mktouchpad "ClickMethod" "2")
    (mktouchpad "NaturalScroll" "true")
    (mktouchpad "TapToClick" "true")
  ];

  utils.kconfig.files.kwinrc.extraScript = ''
    echo '[Wayland]' >> $out
    echo 'InputMethod[$e]=/run/current-system/sw/share/applications/org.fcitx.Fcitx5.desktop' >> $out
  '';
}