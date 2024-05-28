{ config, ... }:
let
  readSecrets = part: builtins.foldl'
    (acc: e: acc // { "${part}/${e}" = { sopsFile = ./secrets.yml; }; })
    {};
  
  pl = config.sops.placeholder;
in {
  sops.secrets = readSecrets "nodes" [
    "a" "b" "c"
    "s1" "s2"
  ];

  utils.encrypted.hosts = {
    "${pl."nodes/a"}" = [ "a.node" ];
    "${pl."nodes/b"}" = [ "b.node" ];
    "${pl."nodes/c"}" = [ "c.node" ];
    "${pl."nodes/s1"}" = [ "s1.node" ];
    "${pl."nodes/s2"}" = [ "s2.node" ];
  };
}