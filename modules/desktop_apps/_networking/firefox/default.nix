{
  nixosModule = { util, user, ... }:
  with util; mkPersistDirsModule user [
    ".mozilla/firefox"
    ".mozilla/native-messaging-hosts"
  ];

  homeModule = { pkgs, ... }: {
    programs.firefox.enable = true;
    programs.firefox.package = pkgs.firefox.override {
      cfg = {
        enablePlasmaBrowserIntegration = true;
        smartcardSupport = true;
      };
    };
  };
}