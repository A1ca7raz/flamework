{ tools, path, ... }:
with tools; let
  activityId = import /${path}/config/activity-id.nix;
in {
  utils.kconfig.rules = [
    ## KDE Daemon
    (mkRule "kded5rc" "Module-baloosearchmodule" "autoload" "false")
    (mkRule "kded5rc" "Module-freespacenotifier" "autoload" "false")
    (mkRule "kded5rc" "Module-kded_accounts" "autoload" "false")
    (mkRule "kded5rc" "Module-kded_bolt" "autoload" "false")
    (mkRule "kded5rc" "Module-browserintegrationreminder" "autoload" "false")
    (mkRule "kded5rc" "Module-plasmavault" "autoload" "false")
    (mkRule "kded5rc" "Module-proxyscout" "autoload" "false")
    (mkRule "kded5rc" "Module-remotenotifier" "autoload" "false")

    ## No Baloo
    (mkRule "kactivitymanagerdrc" "Plugins" "org.kde.ActivityManager.ResourceScoringEnabled" "false")
    (mkRule "kactivitymanagerd-pluginsrc" "Plugin-org.kde.ActivityManager.Resources.Scoring" "what-to-remember" "1")
    # (mkRule "krunnerrc" "Plugins" "baloosearchEnabled" "false")
    (mkRule "baloofilerc" "Basic Settings" "Indexing-Enabled" "false")

    ## Session
    (mkRule "ksmserverrc" "General" "loginMode" "emptySession")

    ## Notifications
    (mkRule "plasmanotifyrc" "Notifications" "PopupPosition" "TopRight")

    ## KActivity
    (mkRule "kactivitymanagerdrc" "activities" activityId "Default")
    (mkRule "kactivitymanagerdrc" "main" "currentActivity" activityId)

    ## Other
    (mkRule "kdeglobals" "General" "BrowserApplication" "firefox.desktop")
    (mkRule "kaccessrc" "ScreenReader" "Enabled" "false")
    (mkRule "kwalletrc" "Wallet" "First Use" "false")
    # ?
    # (mkRule "klipperrc" "General" "IgnoreImages" "false")
    # (mkRule "klipperrc" "General" "MaxClipItems" "30")
  ];
}