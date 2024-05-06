{ lib, var }:
with lib.tags;
rec {
  getTags = var.host.tags;
  tags = getTags;

  hasTag = tag: var.host.tags ? "${tag}";
  is = hasTag;

  isDesktop = is desktop;
  isServer = is server;
  isLocal = is local;
  isRemote = is remote;
  isInternal = is internal;
  isExternal = is external;
  isPublic = is public;
  isPrivate = is private;
  isLaptop = is laptop;

  isDebug = is debug;
}