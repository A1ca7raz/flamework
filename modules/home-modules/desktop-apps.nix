{ ... }:
let
  c = x: ".config/" + x;
  ls = x: ".local/share/" + x;
in
{
  environment.persistence."/nix/persist".users.nomad = {
    directories = [
      (c "chromium")                    # Chromium
      (c "easyeffects")                 # Easyeffects
      (ls "fcitx5")                     # Fcitx5 主题文件
      (ls "fish")                       # Fish
      (c "JetBrains") (ls "JetBrains")  # Jetbrains
      (c "obs-studio")                  # OBS Studio
      (c "sops")                        # SOPS
      (c "spotify")                     # Spotify
      (ls "Steam") ".steam"             # Steam
      (ls "TelegramDesktop")            # Telegram Desktop
      ".mozilla/thunderbird"            # Thunderbird
      ".thunderbird"
      (c "VSCodium") ".vscode-oss"      # VSCodium
      (c "wireshark")                   # WireShark

      # Plasma APPs
      (ls "dolphin")
      (ls "ghostwriter")
      (ls "kate")
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
      (ls "mime")
      (ls "networkmanagement")
      (c "plasma-nm")
      (ls "Trash")
      (ls "vulkan")
      ".local/state/wireplumber"
    ];

    files = [
      (c "bluedevilglobalrc")
      (c "kshisenrc")                # 麻将连连看
      (c "kteatimerc")               # KTeatime
      (ls "user-places.xbel")        # Dolphin 侧栏
      (c "birdtray-config.json")
      # System
      (c "mimeapps.list")
      (c "plasmanotifyrc")
    ];
  };

  imports = [ ./small-apps.nix ];
}