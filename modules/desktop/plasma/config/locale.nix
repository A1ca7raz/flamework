{ home, tools, lib, pkgs, ... }:
let
  wc = tools.wrapWC pkgs;
in {
  home.activation.setupLocale = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${wc "plasma-localerc" "Formats" "LANG" "zh_CN.UTF-8"}
    ${wc "plasma-localerc" "Translations" "LANGUAGE" "zh_CN:en_US"}
    ${wc "ktimezonedrc" "TimeZones" "LocalZone" "Asia/Shanghai"}
    ${wc "ktimezonedrc" "TimeZones" "ZoneinfoDir" "/usr/share/zoneinfo"}
    ${wc "ktimezonedrc" "TimeZones" "Zonetab" "/usr/share/zoneinfo/zone.tab"}

    ${wc "plasma_calendar_alternatecalendar" "General" "calendarSystem" "Chinese"}
    ${wc "plasma_calendar_alternatecalendar" "General" "dateOffset" "0"}

    ${wc "plasma_calendar_holiday_regions" "General" "selectedRegions" "cn_zh-cn"}
  '';
}