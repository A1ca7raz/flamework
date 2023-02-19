{ ... }:
{
  services.flameshot = {
    enable = true;
    settings = {};
  };

  xdg.configFile.flameshot = {
    target = "flameshot/flameshot.ini";
    text = ''
      [General]
      autoCloseIdleDaemon=true
      checkForUpdates=false
      contrastOpacity=188
      copyOnDoubleClick=true
      disabledTrayIcon=false
      drawColor=#0000ff
      drawThickness=3
      filenamePattern=%Y%m%d_%H%M%S
      historyConfirmationToDelete=false
      saveAsFileExtension=jpg
      savePath=/home/nomad/Pictures
      savePathFixed=true
      showDesktopNotification=true
      showStartupLaunchMessage=false
      startupLaunch=true
      undoLimit=100
      uploadHistoryMax=25
      useJpgForClipboard=true
    '';
  };
}