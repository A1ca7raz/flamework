let 
  module = { ... }:
    let
      mktc = { color, opacity, blur, noise ? "0" }: rec {
        inherit color;
        blur = toString blur;
        noise = toString noise;
        kvantumOpacity = toString opacity;
        windecoOpacity = toString (100 - opacity);
        konsoleOpacity = "0." + windecoOpacity;
      };
    in {
      config.lib.themeColor = {
        light = mktc {
          color = "";
          opacity = 36;
          blur = "";
          noise = "";
        };

        dark = mktc {
          color = "";
          opacity = 46;
          blur = "";
          noise = "";
        };
      };
    };
in {
  nixosModule = module;
  homeModule = module;
}