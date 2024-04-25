{ lib, ... }:
{
  lib.global = {
    type = lib.mkDefault "server";
  };
}