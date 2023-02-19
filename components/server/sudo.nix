{ lib, ... }:
{
  security.sudo.wheelNeedsPassword = lib.mkForce false;
}