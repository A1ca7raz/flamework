{ tools, ... }:
with tools; {
  utils.kconfig.files.kwinrc.items = [
    (mkItem "Plugins" "blurEnabled" "true")
    (mkItem "Effect-blur" "BlurStrength" "10")
    (mkItem "Effect-blur" "NoiseStrength" "11")
    # (mkItem "Effect-blur" "BlurStrength" "4")
    # (mkItem "Effect-blur" "NoiseStrength" "0")
    (mkItem "Plugins" "contrastEnabled" "true")
    (mkItem "Plugins" "dynamic_workspacesEnabled" "true")
    (mkItem "Plugins" "kwin4_effect_eyeonscreenEnabled" "true")
    (mkItem "Plugins" "kwin4_effect_windowapertureEnabled" "false")
    (mkItem "Plugins" "kwin4_effect_dimscreenEnabled" "true")
    (mkItem "Effect-kwin4_effect_scale" "InScale" "0.3")
    (mkItem "Effect-kwin4_effect_scale" "OutScale" "0.3")
    (mkItem "Effect-slide" "HorizontalGap" "0")
    (mkItem "Effect-slide" "VerticalGap" "0")
    (mkItem "Effect-slide" "SlideDocks" "true")
  ];
}
