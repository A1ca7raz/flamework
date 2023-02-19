{ util, ... }:
{
  imports = (util.importsFiles ./desktop) ++
    [ ./baseline-apps.nix ];
}