{
  g = {
    blockedAutoColorItems = "spotify-client,birdtray";
    extraItems = "org.kde.plasma.battery,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.plasma.bluetooth,org.kde.plasma.networkmanagement,org.kde.plasma.volume,org.kde.kdeconnect,steam";
    hiddenItems = "KeePassXC,org.kde.kdeconnect,org.kde.plasma.clipboard,birdtray,steam";
    iconsSpacing = "10";
    knownItems = "org.kde.plasma.battery,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.manage-inputmethod,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.kdeconnect,org.kde.kscreen,org.kde.plasma.bluetooth,org.kde.plasma.keyboardindicator,org.kde.plasma.keyboardlayout,org.kde.plasma.networkmanagement,org.kde.plasma.nightcolorcontrol,org.kde.plasma.printmanager,org.kde.plasma.volume";
    reversedBackgroundOpacity = "30";
    reversedBackgroundRadius = "50";
    scaleIconsToFit = "true";
  };

  meta = screenId: {
    formfactor = "2";
    immutability = "1";
    lastScreen = builtins.toString screenId;
    location = "3";
    plugin = "org.kde.plasma.private.systemtray";
  };
}