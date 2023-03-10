{ ... }:
let
  mkMirror = x: "https://${x}/nix-channels/store";
  mkEduMirror = x: mkMirror "mirrors.${x}.edu.cn";
in
{
  nix.settings.substituters = [
    (mkEduMirror "bfsu")
    (mkEduMirror "sjtug.sjtu")
    (mkEduMirror "tuna.tsinghua")
    (mkEduMirror "nju")
    (mkEduMirror "ustc")

    "https://cache.nixos.org/"
  ];
}