{ config, lib, user, ... }:
with lib; let
  mkcl = foldl (acc: i: acc // {
    ${i} = {
      target = c i;
      source = config.utils.kconfig.files."${i}".path;
    };
  }) {};
in mkOverlayModule user (mkcl [
  "kiorc"
  "kdeglobals"
  "kcmfonts"
  "kcminputrc"
  "kwinrc"
  "plasma-localerc"
  "ktimezonedrc"
  "plasma_calendar_alternatecalendar"
  "plasma_calendar_holiday_regions"
  "powerdevilrc"
  "plasmashellrc"
  "powermanagementprofilesrc"
  "kglobalshortcutsrc"
  "kded5rc"
  "kactivitymanagerdrc"
  "kactivitymanagerd-pluginsrc"
  "baloofilerc"
  "ksmserverrc"
  "plasmanotifyrc"
  "kactivitymanagerdrc"
  "kaccessrc"
  "kwalletrc"
  "touchpadxlibinputrc"

  "plasmarc"
  # "sierrabreezeenhancedrc"
  "ksplashrc"
  "kscreenlockerrc"
])