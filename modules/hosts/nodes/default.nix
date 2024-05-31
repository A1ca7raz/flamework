{ config, ... }:
let
  prefix = "nodes";

  nodes = [
    "a"
    "b"
    "c"
    "s1" "s2"
  ];  
in {
  sops.secrets = builtins.foldl'
    (acc: e:
      acc // { "${prefix}/${e}" = { sopsFile = ./secrets.yml; }; }
    ) {} nodes;

  utils.encrypted.reversedHosts = builtins.foldl'
    (acc: e:
      acc // { "${e}.node" = config.sops.placeholder."${prefix}/${e}"; }
    ) {} nodes;
}
