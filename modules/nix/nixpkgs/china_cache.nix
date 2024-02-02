{ ... }:
let
  mkMirror = x: "https://${x}/nix-channels/store?priority=10";
  mkEduMirror = x: mkMirror "mirrors.${x}.edu.cn";
in {
  nix.settings.substituters = [
    (mkEduMirror "ustc")
    (mkEduMirror "bfsu")
#     (mkEduMirror "sjtug.sjtu")
#     (mkEduMirror "nju")
  ];
}
