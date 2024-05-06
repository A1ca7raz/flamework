{ pkgs, ... }:
{
  import = [ ./netns.nix ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16_jit;
    initdbArgs = [ "--locale=zh_CN.UTF-8" "-E UTF8" "--data-checksums" ];

    # set up pgvecto-rs plugin
    extraPlugins = [ pkgs.postgresql16JitPackages.pgvecto-rs ];
    settings = { shared_preload_libraries = "vectors.so"; };
  };
}