{ lib, config, tools, ... }:
{
  lib.vnet.ipAddrs = [ "198.18.10.254/24" ];

  lib.services = {
    # Infra
    postgresql = { domains = [ "psql.insyder" ]; ipAddrs = [ "198.18.10.1/24" ]; };
    caddy = { domains = [ "caddy.insyder" ]; ipAddrs = [ "198.18.10.2/24" ]; };
    minio = { domains = [ "s3.insyder" ]; ipAddrs = [ "198.18.10.3/24" ]; };
    minio-ui = { domains = [ "console.s3.insyder" ]; ipAddrs = [ "198.18.10.7/24" ]; };
    minio-kes = { domains = [ "kes.s3.insyder" ]; ipAddrs = [ "198.18.10.6/24" ]; };
    step-ca = { domains = [ "pki.insyder" ]; ipAddrs = [ "198.18.10.4/24" ]; };
    redis = { domains = [ "redis.insyder" ]; ipAddrs = [ "198.18.10.5/24" ]; };

    # Services
    authentik = { domains = [ "id.insyder" ]; ipAddrs = [ "198.18.10.10/24" ]; };
  };

  networking.hosts =
    with lib; let
      cfg = config.lib.services;
    in foldlAttrs (acc: n: v:
      (foldl (acc_: ip:
        acc_ // { ${ip} = v.domains; }
      ) {} (tools.removeCIDRSuffixes v.ipAddrs)) // acc
    ) {} cfg;
}