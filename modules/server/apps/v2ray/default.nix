{ config, ... }:
{
  sops.secrets.v2ray.restartUnits = ["v2ray.service"];

  services.v2ray = {
    enable = true;

    configFile = config.sops.secrets.v2ray.path;
  };
}
