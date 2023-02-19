{
  lib,
  dolphin,
}:
dolphin.overrideAttrs (p: {
  patches = [ ../../patches/dolphin-return-space.patch ];
})