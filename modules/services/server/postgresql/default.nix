{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;

    initdbArgs = [
      "--locale=zh_CN.UTF-8"
      "-E UTF8"
    ];
  };
}
