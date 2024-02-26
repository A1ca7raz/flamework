{ home, ... }:
{
  # Exported from Search Engines Helper
  programs.firefox.profiles.Default.search.engines = with builtins;
    fromJSON (readFile ./all-browser-engines.json);
}