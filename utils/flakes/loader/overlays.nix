{ util, path, lib, ... }:
let
  overlay_path = /${path}/overlays;

in util.foldGetFile overlay_path [] (x: y:
    if util.isNix x
    then [ (import /${overlay_path}/${x} { inherit util lib; }) ] ++ y else y
  )
