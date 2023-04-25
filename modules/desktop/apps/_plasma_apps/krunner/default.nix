{ home, ... }:
{
  xdg.configFile.krunnerrc = {
    target = "krunnerrc";
    text = ''
      [General]
      FreeFloating=true

      [PlasmaRunnerManager]
      migrated=true

      [Plugins]
      CharacterRunnerEnabled=true
      DictionaryEnabled=true
      Kill RunnerEnabled=true
      PIM Contacts Search RunnerEnabled=true
      PowerDevilEnabled=true
      Spell CheckerEnabled=true
      appstreamEnabled=true
      baloosearchEnabled=false
      bookmarksEnabled=true
      browserhistoryEnabled=true
      browsertabsEnabled=true
      calculatorEnabled=true
      desktopsessionsEnabled=true
      katesessionsEnabled=true
      konsoleprofilesEnabled=true
      krunner_systemsettingsEnabled=true
      kwinEnabled=true
      locationsEnabled=true
      org.kde.activities2Enabled=true
      org.kde.datetimeEnabled=true
      org.kde.windowedwidgetsEnabled=true
      placesEnabled=true
      plasma-desktopEnabled=true
      recentdocumentsEnabled=true
      servicesEnabled=true
      shellEnabled=true
      unitconverterEnabled=true
      webshortcutsEnabled=true
      windowsEnabled=true
    '';
  };
}