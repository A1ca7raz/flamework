{ config, tools, lib, user, ... }:
with tools; let
  mkcl = lib.foldl (acc: i: acc // {
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
])