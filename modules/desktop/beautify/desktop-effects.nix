{ util, lib, pkgs, constant, ... }:
let
  wc = util.wrapWC pkgs;
in {
  home.activation.setupDesktopEffects = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${wc "kwinrc" "Plugins" "blurEnabled" "true"}
    ${wc "kwinrc" "Effect-blur" "BlurStrength" "10"}
    ${wc "kwinrc" "Effect-blur" "NoiseStrength" "11"}
    # ${wc "kwinrc" "Effect-blur" "BlurStrength" "4"}
    # ${wc "kwinrc" "Effect-blur" "NoiseStrength" "0"}
    ${wc "kwinrc" "Plugins" "contrastEnabled" "true"}
    ${wc "kwinrc" "Plugins" "kwin4_effect_eyeonscreenEnabled" "true"}
    ${wc "kwinrc" "Plugins" "kwin4_effect_windowapertureEnabled" "false"}
    ${wc "kwinrc" "Plugins" "kwin4_effect_dimscreenEnabled" "true"}
    ${wc "kwinrc" "Effect-kwin4_effect_scale" "InScale" "0.3"}
    ${wc "kwinrc" "Effect-kwin4_effect_scale" "OutScale" "0.3"}
    ${wc "kwinrc" "Effect-slide" "HorizontalGap" "0"}
    ${wc "kwinrc" "Effect-slide" "VerticalGap" "0"}
    ${wc "kwinrc" "Effect-slide" "SlideDocks" "true"}
  '';
}