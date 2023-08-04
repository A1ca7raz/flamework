{
  nixosModule = { user, util, lib, ... }:
  with util; lib.mkMerge [
    (mkPersistDirsModule user [
      ".mozilla/thunderbird"
      ".thunderbird"
    ])
    (mkPersistFilesModule user [
      (c "birdtray-config.json")
    ])
  ];

  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      birdtray
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
