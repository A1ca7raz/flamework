{ ... }:
{
  utils.gitea = {
    cache = {
      ENABLED = true;
      ADAPTER = "redis";
      HOST = "redis://:gitea@127.0.0.1:63792/0";
    };
  };
}