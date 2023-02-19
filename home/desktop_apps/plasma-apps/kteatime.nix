{ ... }:
{
  xdg.configFile.kteatime_notifyrc = {
    target = "kteatime.notifyrc";
    text = ''
      [Event/popup]
      Action=Popup|Taskbar
      Execute=
      Logfile=
      Sound=
      TTS=

      [Event/ready]
      Action=Sound|Popup
      Execute=
      Logfile=
      TTS=

      [Event/reminder]
      Action=Sound|Popup
      Execute=
      Logfile=
      TTS=
    '';
  };
}