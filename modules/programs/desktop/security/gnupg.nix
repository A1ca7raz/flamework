{
  nixosModule = { user, pkgs, tools, ... }: {
    environment.persistence = tools.mkPersistDirsTree user [
      ".gnupg"
    ];

    programs.gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-qt;
        enableBrowserSocket = true;
        enableExtraSocket = true;
        enableSSHSupport = true;
      };
      dirmngr.enable = true;
    };

    services.pcscd.enable = true;
    hardware.gpgSmartcards.enable = true;
  };
  
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      paperkey 
      qrencode
    ];
  };
}