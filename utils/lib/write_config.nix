{ lib, ... }:
with lib; let
  wrapper = func: pkgs:
  let
    kwc = pkgs.libsForQt5.kconfig;
  in
    func kwc;
in rec {
  wrapWC_ = wrapper
    (kc: file: group: key: value:
    let
      groupstr = fold (x: y: ''--group "${x}" '' + y) "" group;
      cmd = "kwriteconfig5 --file ${file} ${groupstr}--key '${key}' '${value}'";
    in
      ''echo -E ${cmd} && $DRY_RUN_CMD ${kc}/bin/${cmd}''
    );

  wrapWC = pkgs: f: g: k: v:
    wrapWC_ pkgs "$HOME/.config/${f}" [g] k v;
}