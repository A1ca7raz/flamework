{
  nixosModule = { util, user, ... }:
  with util; mkPersistDirsModule user [
    ".mozilla/firefox"
    (ls "tor-browser")
  ];

  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      (firefox.override {
        nativeMessagingHosts = [
          plasma-browser-integration
          keepassxc
        ];
        cfg.smartcardSupport = true;
      })
      tor-browser
    ];
  };
}
