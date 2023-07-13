{ ... }:
# /etc/profiles/per-user/nomad/share/applications/
let
  # Inline Functions
  mkApp = x: "${x}.desktop";

  # Normal Apps
  kate = mkApp "org.kde.kate";
  vsc = mkApp "codium";                          # VSCode (VSCodium)
  ghostwriter = mkApp "org.kde.ghostwriter";     # Default Markdown Editor
  chromium = mkApp "chromium-browser";
  mpv = mkApp "mpv";
  vlc = mkApp "vlc";
in {
  xdg.mimeApps.enable = true;
  xdg.mimeApps = {
    associations.added = {
      "text/markdown" = [ ghostwriter kate vsc ];
      "application/x-zerosize" = [ kate ];
    };

    defaultApplications = {
      "text/markdown" = ghostwriter;
      "text/plain"    = kate;
      "video/mp4" = mpv;
      "application/pdf" = chromium;
      "application/x-zerosize" = kate;
    };
  };
}