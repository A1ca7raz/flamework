{ pkgs, lib, config, tools, ... }:
let
  inherit (config.lib.services.postgresql) ipAddrs;
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
      ] ++ (tools.removeCIDRSuffixes ipAddrs)));
    };

    authentication = ''
      host all all ${config.lib.subnet.v4Full} md5
      host all all ${config.lib.subnet.v6Full} md5
    '';

    # set up pgvecto-rs plugin
    extraPlugins = [ pkgs.postgresql16JitPackages.pgvecto-rs ];
    settings = { shared_preload_libraries = "vectors.so"; };
  };

  # add support for netns
  utils.netns.veth.psql = {
    bridge = "0";
    netns = "psql";
    inherit ipAddrs;
  };

  systemd.services.postgresql = {
    after = [ "netns-veth-psql.service" ];
    bindsTo = [ "netns-veth-psql.service" ];
    serviceConfig.NetworkNamespacePath = "/run/netns/psql";
  };
}