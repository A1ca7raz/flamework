{ ... }:
{
  utils.ocis.cache = {
    store = "redis";
    nodes = "127.0.0.1:63793";
    ttl = 108000;
  };
}