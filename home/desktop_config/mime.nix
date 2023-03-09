{ ... }:
let
  # Inline Functions
  mkApp = x: "${x}.desktop";

  # Normal Apps
  kate = mkApp "org.kde.kate";
  vsc = mkApp "codium";         # VSCode (VSCodium)
  md = mkApp "ghostwriter";     # Default Markdown Editor
in
{
  xdg.mimeApps.enable = true;
  xdg.mimeApps = {
    associations.added = {
      "text/markdown" = [ md kate vsc ];
    };

    defaultApplications = {
      "text/markdown" = md;
      "text/plain"    = kate;
    };
  };
}