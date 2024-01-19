lib:
with builtins; rec {
  removeCIDRSuffix = ip: elemAt (split "/([0-9]+)$" ip) 0;

  removeCIDRSuffixes = ips: lib.forEach ips removeCIDRSuffix;
}