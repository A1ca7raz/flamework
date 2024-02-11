{ tools, ... }:
with tools; {
  utils.kconfig.rules = [
    (mkRule "kdeglobals" "KScreen" "ScaleFactor" "1.0625")
    (mkRule "kwinrc" "Compositing" "WindowsBlockCompositing" "false")
    (mkRule "kwinrc" "Compositing" "LatencyPolicy" "ExtremelyHigh")
  ];
}