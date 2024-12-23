{ home, pkgs, ... }:
let
  sound = "/run/current-system/sw/share/sounds/speech-dispatcher/test.wav";
in {
  systemd.user.services.hourly-alarm = {
    Unit.Description = "Hourly Alarm";
    Service = {
      Type = "oneshot";
      ExecStart = [
        "${pkgs.pipewire}/bin/pw-play ${sound}"
        ''${pkgs.libnotify}/bin/notify-send -a 整点报时 -i clock -h string:desktop-entry:hourly-alarm "$(date +%%H) 点啦！"''
      ];
    };
  };

  systemd.user.timers.hourly-alarm = {
    Unit.Description = "Hourly Alarm Timer";
    Timer.OnCalendar = "*:00";
    Install.WantedBy = [ "timers.target" ];
  };

  xdg.desktopEntries.hourly-alarm = {
    noDisplay = true;
    name = "Hourly Alarm";
    icon = "alarm-clock";
    type = "Application";
  };
}
