{ home, pkgs, ... }:
{
  home.packages = [ pkgs.tor-browser ];

  programs.firefox.enable = true;
  programs.firefox.package = with pkgs; firefox.override {
    nativeMessagingHosts = [
      plasma-browser-integration
    ];
    cfg.smartcardSupport = true;
  };
}