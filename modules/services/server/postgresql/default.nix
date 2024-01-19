{ pkgs, lib, config, ... }:
let
  constant = config.lib.services.postgresql;
in {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16_jit;
    initdbArgs = [ "--locale=zh_CN.UTF-8" "-E UTF8" "--data-checksums" ];

    settings = {
      listen_addresses = with lib; mkForce (concatStringsSep ", " ([
        "127.0.0.1" "::1"
        # config.lib.this.ip4
        # config.lib.this.ip6
      ]) ++ constant.ipAddrs);
    };

    authentication = ''
      host all all ${config.lib.subnet.v4Full} md5
      host all all ${config.lib.subnet.v6Full} md5
    '';
  };
}