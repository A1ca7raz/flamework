{ util, lib, self, path, ... }:
let
  overlay_path = /${path}/overlays;

  # defaultOverlay = final: prev: {
  #   final.util = util;
  #   final.path = path;
  # };

in util.foldGetFile overlay_path [] (x: y:
    if util.isNix x
    then [ (import /${overlay_path}/${x}) ] ++ y else y
  )
