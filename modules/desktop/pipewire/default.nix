{ pkgs, ... }:
{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };

  # Realtime Priority
  systemd.services.rtkit-daemon.serviceConfig.ExecStart = [
    ""
    "${pkgs.rtkit}/libexec/rtkit-daemon --no-canary"
  ];

  security.pam.loginLimits =
    let
      mkLimit = a: b: c: d: { domain = a; type = b; item = c; value = d; };
    in [
      (mkLimit "@realtime" "-" "rtprio" "98")
      (mkLimit "@realtime" "-" "memlock" "unlimited")
      (mkLimit "@realtime" "-" "nice" "-11")
    ];

  services.udev.extraRules = ''
    # rw access to /dev/cpu_dma_latency to prevent CPUs from going into idle state
    KERNEL=="cpu_dma_latency", GROUP="realtime"
  '';

  users.groups.realtime = {};
}
