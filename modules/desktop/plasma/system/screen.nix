{ lib, user, ... }:
with lib; {
  utils.kconfig.rules = [
    (mkRule "kdeglobals" "KScreen" "ScaleFactor" "1.0625")
    (mkRule "kwinrc" "Compositing" "WindowsBlockCompositing" "false")
    (mkRule "kwinrc" "Compositing" "LatencyPolicy" "ExtremelyHigh")
  ];

  system.userActivationScripts.kwinconfigoutput = {
    text = ''
      [[ -L $HOME/.config/kwinoutputconfig.json ]] || \
      ln -sf $VERBOSE_ARG \
        /nix/persist/home/${user}/.config/kwinoutputconfig.json $HOME/.config/kwinoutputconfig.json
    '';
    deps = [];
  };
}