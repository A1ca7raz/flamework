{ util, lib, path, pkgs, ... }:
let
  wc = util.wrapWC pkgs;
  activityId = import /${path}/config/activity-id.nix;
in {
  home.activation.setupSystem = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ## KDE Daemon
    ${wc "kded5rc" "Module-baloosearchmodule" "autoload" "false"}
    ${wc "kded5rc" "Module-freespacenotifier" "autoload" "false"}
    ${wc "kded5rc" "Module-kded_accounts" "autoload" "false"}
    ${wc "kded5rc" "Module-kded_bolt" "autoload" "false"}
    ${wc "kded5rc" "Module-browserintegrationreminder" "autoload" "false"}
    ${wc "kded5rc" "Module-plasmavault" "autoload" "false"}
    ${wc "kded5rc" "Module-proxyscout" "autoload" "false"}
    ${wc "kded5rc" "Module-remotenotifier" "autoload" "false"}

    ## No Baloo
    ${wc "kactivitymanagerdrc" "Plugins" "org.kde.ActivityManager.ResourceScoringEnabled" "false"}
    ${wc "kactivitymanagerd-pluginsrc" "Plugin-org.kde.ActivityManager.Resources.Scoring" "what-to-remember" "1"}
    # ${wc "krunnerrc" "Plugins" "baloosearchEnabled" "false"}
    ${wc "baloofilerc" "Basic Settings" "Indexing-Enabled" "false"}

    ## Session
    ${wc "ksmserverrc" "General" "loginMode" "emptySession"}

    ## Notifications
    ${wc "plasmanotifyrc" "Notifications" "PopupPosition" "TopRight"}

    ## KActivity
    ${wc "kactivitymanagerdrc" "activities" activityId "Default"}
    ${wc "kactivitymanagerdrc" "main" "currentActivity" activityId}

    ## Other
    ${wc "kdeglobals" "General" "BrowserApplication" "chromium.desktop"}
    ${wc "kaccessrc" "ScreenReader" "Enabled" "false"}
    ${wc "kwalletrc" "Wallet" "First Use" "false"}
    # ?
    # ${wc "klipperrc" "General" "IgnoreImages" "false"}
    # ${wc "klipperrc" "General" "MaxClipItems" "30"}
  '';
}