{ lib, ... }:
final: prev:
{
  libsForQt5 = prev.libsForQt5.overrideScope' (gf: gp: {
    dolphin = gp.dolphin.overrideAttrs (p: {
      patches = p.patches ++ [ ../patches/dolphin-return-space.patch ];
    });
  });
}