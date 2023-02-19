{ ... }:
{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;

    config = {
      client = {
        "stream.properties"."resample.quality" = 10;
      };
      client-rt = {
        "stream.properties"."resample.quality" = 10;
      };
      jack = {
        "stream.properties"."resample.quality" = 10;
      };
      pipewire-pulse = {
        "stream.properties"."resample.quality" = 10;
      };
    };
  };
}