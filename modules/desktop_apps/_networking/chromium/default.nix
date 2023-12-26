{
  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      (c "chromium")
    ];

  homeModule = { pkgs, ... }: {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium-drm;

#       commandLineArgs = [
#         "--ignore-gpu-blocklist"
#         "--enable-gpu-rasterization"
#         "--enable-zero-copy"
#         "--use-gl=egl"
#
#         "--enable-features=VaapiVideoDecoder"
#         "--enable-features=VaapiIgnoreDriverChecks"
#         "--disable-features=UseChromeOSDirectVideoDecoder"
#         "--enable-features=PlatformHEVCDecoderSupport"
#
#         "--enable-features=WebUIDarkMode"
#         "--force-dark-mode"
#       ];
    };
  };
}
