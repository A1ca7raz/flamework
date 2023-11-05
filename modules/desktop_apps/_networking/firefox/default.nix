{
  nixosModule = { util, user, ... }:
  with util; mkPersistDirsModule user [
    ".mozilla/firefox"
    ".mozilla/native-messaging-hosts"
    (ls "tor-browser")
  ];

  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      (firefox.override {
        cfg = {
          enablePlasmaBrowserIntegration = true;
          smartcardSupport = true;
        };
      })
      tor-browser
    ];
  };
}