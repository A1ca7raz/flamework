{ lib, config, tools, ... }:
{
  lib.vnet.ipAddrs = [ "198.18.10.254/24" ];

  lib.services = {
    # Infra
    postgresql = { domains = [ "psql.insyder" ]; ipAddrs = [ "198.18.10.1/24" ]; };
    caddy = { domains = [ "caddy.insyder" ]; ipAddrs = [ "198.18.10.2/24" ]; };
    step-ca = { domains = [ "pki.insyder" ]; ipAddrs = [ "198.18.10.4/24" ]; };
    redis = { domains = [ "redis.insyder" ]; ipAddrs = [ "198.18.10.5/24" ]; };

    # Services
    gitea = { domains = [ "git.insyder" ]; ipAddrs = [ "198.18.10.11/24" ]; };
    ocis = { domains = [ "drive.insyder" ]; ipAddrs = [ "198.18.10.12/24" ]; };
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