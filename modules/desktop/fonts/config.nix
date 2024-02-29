{ ... }:
{
  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;
    fontconfig.cache32Bit = true;
  };

  fonts.fontconfig = {
    hinting.enable = false;
    hinting.style = "none";

    subpixel.rgba = "rgb";
    subpixel.lcdfilter = "default";

    useEmbeddedBitmaps = false;
    antialias = true;
  };
}