{ lib, tools, pkgs, ... }:
let
  wc = tools.wrapWC pkgs;
in {
  home.activation.setupScreen = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${wc "kdeglobals" "KScreen" "ScaleFactor" "1.0625"}
    ${wc "kwinrc" "Compositing" "WindowsBlockCompositing" "false"}
    ${wc "kwinrc" "Compositing" "LatencyPolicy" "ExtremelyHigh"}
  '';
}