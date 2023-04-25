{ pkgs, lib, util, ... }:
let
  _wc = util.wrapWC pkgs;
  wc = _wc "sierrabreezeenhancedrc";
  wcdeo = wc "Windeco";

  mkShadow = id: n: ''
    echo -e "[Windeco Exception ${toString id}]\n\
    BorderSize=2\n\
    DrawBackgroundGradient=false\n\
    DrawTitleBarSeparator=false\n\
    Enabled=true\n\
    ExceptionPattern=${n}\n\
    ExceptionType=0\n\
    GradientOverride=-1\n\
    HideTitleBar=3\n\
    IsDialog=false\n\
    Mask=0\n\
    MatchColorForTitleBar=true\n\
    OpacityOverride=-1\n\
    OpaqueTitleBar=false" >> $HOME/.config/sierrabreezeenhancedrc
  '';
in {
  home.packages = [ pkgs.sierra-breeze-enhanced ];

  home.activation.setupWindeco = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${wc "Common" "ShadowSize" "ShadowSmall"}
    ${wcdeo "ButtonStyle" "sbeDarkAuroraeActive"}
    ${wcdeo "DrawBackgroundGradient" "false"}
    ${wcdeo "DrawTitleBarSeparator" "false"}
    ${wcdeo "OpaqueTitleBar" "false"}
    ${wcdeo "UnisonHovering" "false"}
    ${mkShadow 0 "Steam"}
    # Light 80 Dark 55
    # ${wcdeo "BackgroundOpacity" ""}
  '';
}