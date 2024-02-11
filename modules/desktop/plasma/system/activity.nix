{ tools, config, ... }:
let
  inherit (config.lib.plasma) activityId;
in {
  lib.plasma.activityId = "114514aa-bbcc-ddee-ff00-1919810abcde";
  utils.kconfig.rules = with tools; [
    ## No Baloo
    (mkRule "kactivitymanagerdrc" "Plugins" "org.kde.ActivityManager.ResourceScoringEnabled" "false")
    (mkRule "kactivitymanagerd-pluginsrc" "Plugin-org.kde.ActivityManager.Resources.Scoring" "what-to-remember" "1")
    (mkRule "baloofilerc" "Basic Settings" "Indexing-Enabled" "false")

    ## KActivity
    (mkRule "kactivitymanagerdrc" "activities" activityId "Default")
    (mkRule "kactivitymanagerdrc" "main" "currentActivity" activityId)
  ];
}