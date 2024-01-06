{
  nixosModule = { user, tools, ... }: {
    environment.persistence = tools.mkPersistDirsTree user [
      ".gnupg"
    ];

    programs.gnupg = {
      agent = {
        enable = true;
        # pinentryFlavor = "qt";
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