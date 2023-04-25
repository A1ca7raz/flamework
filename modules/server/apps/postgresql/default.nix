{ config, pkgs, lib, ... }:
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_14;

    initdbArgs = [
      "--locale=zh_CN.UTF-8"
      "-E UTF8"
    ];
  };
}
