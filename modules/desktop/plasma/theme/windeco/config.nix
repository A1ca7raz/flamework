{ lib, tools, ... }:
with tools; with lib; let
  mkException = id: attr:
    generators.toINI {} { "Windeco Exception ${builtins.toString id}" = attr; };

  mkExceptions = apps:
    "cat >> $out << EOF\n\n" + (concatStringsSep "\n" (imap0 (i: v: mkException i {
      BorderSize = "2";
      DrawBackgroundGradient = "false";
      DrawTitleBarSeparator = "false";
      Enabled = "true";
      ExceptionPattern = v;
      ExceptionType = "0";
      GradientOverride = "-1";
      HideTitleBar = "3";
      IsDialog = "false";
      Mask = "0";
      MatchColorForTitleBar = "true";
      OpacityOverride = "-1";
      OpaqueTitleBar = "false";
    }) apps)) + "\nEOF";
in {
  utils.kconfig.files.sierrabreezeenhancedrc.items = [
    (mkItem "Common" "ShadowSize" "ShadowSmall")
    (mkItem "Windeco" "BackgroundOpacity" "64")
    (mkItem "Windeco" "ButtonStyle" "sbeDarkAuroraeActive")
    (mkItem "Windeco" "DrawBackgroundGradient" "false")
    (mkItem "Windeco" "DrawTitleBarSeparator" "false")
    (mkItem "Windeco" "HideTitleBar" "MaximizedWindows")
    (mkItem "Windeco" "OpaqueTitleBar" "false")
    (mkItem "Windeco" "UnisonHovering" "false")
  ];

  # NOTE: kwriteconfig does not support '-'
  utils.kconfig.files.sierrabreezeenhancedrc.extraScript = mkExceptions [
    "steam$"
    "^et"
    "^wps"
    "^wpp"
    "^pdf"
    "^wpsoffice"
  ];
}