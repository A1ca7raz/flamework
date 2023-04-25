{ home, ... }:
{
  xdg.configFile = {
    konsolerc = {
      target = "konsolerc";
      text = ''
        [Desktop Entry]
        DefaultProfile=Default.profile

        [KonsoleWindow]
        RememberWindowSize=false
        ShowWindowTitleOnTitleBar=true

        [MainWindow]
        State=AAAA/wAAAAD9AAAAAQAAAAAAAAESAAACWvwCAAAAAvsAAAAcAFMAUwBIAE0AYQBuAGEAZwBlAHIARABvAGMAawAAAAAAAAABFgAAANIA////+wAAACIAUQB1AGkAYwBrAEMAbwBtAG0AYQBuAGQAcwBEAG8AYwBrAAAAAAAAAAJaAAABQAD///8AAAOWAAACWgAAAAQAAAAEAAAACAAAAAj8AAAAAQAAAAIAAAACAAAAFgBtAGEAaQBuAFQAbwBvAGwAQgBhAHIAAAAAAP////8AAAAAAAAAAAAAABwAcwBlAHMAcwBpAG8AbgBUAG8AbwBsAGIAYQByAAAAAAD/////AAAAAAAAAAA=

        [Notification Messages]
        CloseAllTabs=true
      '';
    };

    konsole_notifyrc = {
      target = "konsole.notifyrc";
      text = ''
        [Event/BellInvisible]
        Action=Sound|Popup
        Execute=
        Logfile=
        TTS=

        [Event/BellVisible]
        Action=
        Execute=
        Logfile=
        Sound=
        TTS=

        [Event/Finished]
        Action=
        Execute=
        Logfile=
        Sound=
        TTS=

        [Event/ProcessFinished]
        Execute=
        Logfile=
        Sound=
        TTS=

        [Event/ProcessFinishedHidden]
        Execute=
        Logfile=
        Sound=
        TTS=

        [Event/SilenceHidden]
        Execute=
        Logfile=
        Sound=
        TTS=
      '';
    };
  };

  home.file.konsole_gui = {
    target = ".local/share/kxmlgui5/konsole/partui.rc";
    text = ''
      <?xml version='1.0'?>
      <!DOCTYPE gui SYSTEM 'kpartgui.dtd'>
      <gui name="konsolepart" version="14" translationDomain="konsole">
        <Menu name="session-popup-menu">
          <Action name="edit_copy_contextmenu"/>
          <Action name="edit_paste"/>
          <Action name="web-search"/>
          <Action name="open-browser"/>
          <Separator/>
          <Action name="set-encoding"/>
          <Separator/>
          <Action name="edit_find"/>
          <Menu name="history">
            <text>S&amp;crollback</text>
            <Action name="file_save_as" group="session-history-operations"/>
            <Separator group="session-history-operations"/>
            <Action name="adjust-history" group="session-history-operations"/>
            <Separator group="session-history-operations"/>
            <Action name="clear-history" group="session-history-operations"/>
            <Action name="clear-history-and-reset" group="session-history-operations"/>
          </Menu>
          <Separator/>
          <Action name="view-readonly"/>
          <Action name="allow-mouse-tracking"/>
          <Separator/>
          <Action name="switch-profile"/>
          <Action name="edit-current-profile"/>
          <Action name="manage-profiles"/>
          <Separator/>
          <Action name="close-session"/>
        </Menu>
        <ActionProperties>
          <Action name="close-session" shortcut=""/>
        </ActionProperties>
      </gui>
    '';
  };
}