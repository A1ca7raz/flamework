{
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      # audacity
      barrier
      # drawio
      fsearch
      # gimp
      inkscape
      libnotify
      libqalculate
      lm_sensors

      logseq
      qalculate-qt
      sbctl
      sops
      baidupcs-go
    ];
  };

  nixosModule = { user, lib, pkgs, ... }:
  let
    c = x: ".config/" + x;
    ls = x: ".local/share/" + x;
  in rec {
    environment.persistence."/nix/persist".users.${user} = {
      directories = [
        (ls "fish")                       # Fish
        (c "sops")                        # SOPS
        (c "BaiduPCS-Go")                 # 百度网盘

        # Plasma APPs
        (c "kdeconnect")
        (ls "krita")

        # System
        (ls "applications")
        (ls "gvfs-metadata")
        (ls "kactivitymanagerd")
        (ls "kcookiejar")
        (ls "kded5")
        (ls "keyrings")
        (ls "klipper")
        (ls "kscreen")
        (ls "kwalletd")
        (c "libaccounts-glib")
        (ls "networkmanagement")
        (c "plasma-nm")
        (ls "Trash")
        (ls "vulkan")
        ".local/state/wireplumber"

        (ls "barrier")                  # Barrier
        (c "draw.io")                   # Draw.io
        (c "GIMP")                      # GIMP
        (c "Logseq") ".logseq"          # Logseq
        (ls "qalculate")                # Qalc
      ];

      files = [
        (c "bluedevilglobalrc")
        (ls "user-places.xbel")        # Dolphin 侧栏
        # System
        (c "plasmanotifyrc")

        (c "Debauchee/Barrier.conf")  # Barrier
      ];
    };
  };
}
