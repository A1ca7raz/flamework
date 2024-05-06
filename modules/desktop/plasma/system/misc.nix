{ lib, ... }:
{
  utils.kconfig.rules = with lib; [
    ## KDE Daemon
    (mkRule "kded5rc" "Module-baloosearchmodule" "autoload" "false")
    (mkRule "kded5rc" "Module-freespacenotifier" "autoload" "false")
    (mkRule "kded5rc" "Module-kded_accounts" "autoload" "false")
    (mkRule "kded5rc" "Module-kded_bolt" "autoload" "false")
    (mkRule "kded5rc" "Module-browserintegrationreminder" "autoload" "false")
    (mkRule "kded5rc" "Module-plasmavault" "autoload" "false")
    (mkRule "kded5rc" "Module-proxyscout" "autoload" "false")
    (mkRule "kded5rc" "Module-remotenotifier" "autoload" "false")

    ## Session
    (mkRule "ksmserverrc" "General" "loginMode" "emptySession")

    ## Notifications
    (mkRule "plasmanotifyrc" "Notifications" "PopupPosition" "TopRight")

    ## Other
    (mkRule "kdeglobals" "General" "BrowserApplication" "firefox.desktop")
    (mkRule "kaccessrc" "ScreenReader" "Enabled" "false")
    (mkRule "kwalletrc" "Wallet" "First Use" "false")
  ];
}