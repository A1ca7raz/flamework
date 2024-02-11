{ tools, ... }:
{
  utils.kconfig.rules = with tools; [
    (mkRule "plasma-localerc" "Formats" "LANG" "zh_CN.UTF-8")
    (mkRule "plasma-localerc" "Translations" "LANGUAGE" "zh_CN:en_US")

    (mkRule "ktimezonedrc" "TimeZones" "LocalZone" "Asia/Shanghai")
    (mkRule "ktimezonedrc" "TimeZones" "ZoneinfoDir" "/usr/share/zoneinfo")
    (mkRule "ktimezonedrc" "TimeZones" "Zonetab" "/usr/share/zoneinfo/zone.tab")

    (mkRule "plasma_calendar_alternatecalendar" "General" "calendarSystem" "Chinese")
    (mkRule "plasma_calendar_alternatecalendar" "General" "dateOffset" "0")

    (mkRule "plasma_calendar_holiday_regions" "General" "selectedRegions" "cn_zh-cn")
  ];
}