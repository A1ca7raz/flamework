{ lib, ... }:
let
  disableModule = x: lib.mkRule "kded5rc" "Module-${x}" "autoload" "false";
in {
  utils.kconfig.rules = with lib; [
    ## KDE Daemon
    (disableModule "baloosearchmodule")
    (disableModule "browserintegrationreminder")
    (disableModule "colorcorrectlocationupdater")
    (disableModule "device_automounter")
    (disableModule "donationmessage")
    (disableModule "freespacenotifier")
    (disableModule "kded_accounts")
    (disableModule "kded_bolt")
    (disableModule "plasmavault")
    (disableModule "proxyscout")

    ## Session
    (mkRule "ksmserverrc" "General" "loginMode" "emptySession")

    ## Notifications
    (mkRule "plasmanotifyrc" "Notifications" "PopupPosition" "TopRight")

    ## Other
    (mkRule "kdeglobals" "General" "BrowserApplication" "firefox.desktop")
    (mkRule "kaccessrc" "ScreenReader" "Enabled" "false")
    (mkRule "kwalletrc" "Wallet" "First Use" "false")

    ## Shakecursor
    (mkRule "kdeglobals" "Effect-shakecursor" "Magnification" "2")
  ];
}
