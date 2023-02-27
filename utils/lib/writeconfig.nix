{ lib, pkgs, ... }:
let
  kc = pkgs.libsForQt5.kconfig;
in
rec {
  wc_ = file: group: key: value:
    let
      groupstr = lib.fold (x: y: ''--group "${x}" '' + y) "" group;
      cmd = "kwriteconfig5 --file ${file} ${groupstr}--key '${key}' '${value}'";
    in
    ''echo -E ${cmd} && $DRY_RUN_CMD ${kc}/bin/${cmd}'';

  wc = f: g: k: v: wc_ "$HOME/.config/${f}" [g] k v;
}