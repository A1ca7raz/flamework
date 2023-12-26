{
  nixosModule = { user, tools, lib, ... }:
    with tools; lib.mkMerge [
      (mkPersistDirsModule user [
        ".mozilla/thunderbird"
        ".thunderbird"
      ])
      (mkOverlayModule user {
        birdtray-config = {
          target = c "birdtray-config.json";
          source = ./birdtray-config.json;
        };
      })
    ];

  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      birdtray-ya
      (thunderbird.override {
        cfg = {
          smartcardSupport = true;
        };
      })
    ];

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/mailto" = "thunderbird.desktop";
      };
    };
  };
}
