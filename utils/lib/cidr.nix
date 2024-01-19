lib:
with builtins; {
  removeCIDRSuffix = ip: elemAt (split "/([0-9]+)$" ip) 0;
}