{ lib, pkgs, ... }:
let
  c = x: ".config/" + x;
  ls = x: ".local/share/" + x;
in
{
  environment.persistence."/nix/persist".users.nomad = {
    directories = [
      (ls "barrier")                  # Barrier
      (c "draw.io")                   # Draw.io
      (c "Element")                   # Element Desktop
      (c "GIMP")                      # GIMP
      (c "Logseq") ".logseq"          # Logseq
      (ls "qalculate")                # Qalc
      (c "vlc")                       # VLC
      (c "kingsoft") (ls "Kingsoft")  # WPS Office
    ];

    files = [
      (c "Debauchee/Barrier.conf")  # Barrier
    ];
  };

  security.wrappers.clash-verge = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_bind_service,cap_net_admin=+ep";
    source = "${lib.getExe pkgs.clash-verge}";
  };
}