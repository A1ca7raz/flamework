{ ... }:
{
  xdg.configFile = {
    yakuakerc = {
      target = "yakuakerc";
      text = ''
        [Appearance]
        Blur=true
        TerminalHighlightOnManualActivation=true

        [Desktop Entry]
        DefaultProfile=Dark.profile

        [Dialogs]
        ConfirmQuit=false
        FirstRun=false

        [Shortcuts]
        help_whats_this=none
        new-session=Alt+T

        [Window]
        KeepAbove=false
        KeepOpen=false
        KeepOpenAfterLastSessionCloses=true
        ShowSystrayIcon=false
        Width=80
      '';
    };

    yakuake_notifyrc = {
      target = "yakuake.notifyrc";
      text = ''
        [Event/BellInvisible]
        Action=Sound|Popup
        Execute=
        Logfile=
        TTS=

        [Event/BellVisible]
        Action=Sound|Popup
        Execute=
        Logfile=
        Sound=
        TTS=

        [Event/activity]
        Action=
        Execute=
        Logfile=
        Sound=
        TTS=

        [Event/silence]
        Action=
        Execute=
        Logfile=
        Sound=
        TTS=
      '';
    };
  };
}