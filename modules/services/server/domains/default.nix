{ lib, var, ... }:
{
  networking.hosts = with lib;
    let
      cfg = var.services;
    in foldlAttrs (acc: n: v:
      (foldl (acc_: ip:
        acc_ // { ${ip} = v.domains; }
      ) {} (removeCIDRSuffixes v.ipAddrs)) // acc
    ) {} cfg;
}