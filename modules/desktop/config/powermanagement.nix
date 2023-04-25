{ ... }:
{
  xdg.configFile = {
    powerdevilrc = {
      target = "powerdevilrc";
      text = ''
        [BatteryManagement]
        BatteryCriticalAction=1 
      '';
    };

    powermanagementprofilesrc = {
      target = "powermanagementprofilesrc";
      text = ''
        [AC]
        icon=battery-charging

        [AC][BrightnessControl]
        value=100

        [AC][HandleButtonEvents]
        lidAction=64
        powerButtonAction=16
        powerDownAction=16
        triggerLidActionWhenExternalMonitorPresent=false

        [Battery]
        icon=battery-060

        [Battery][BrightnessControl]
        value=100

        [Battery][DPMSControl]
        idleTime=600

        [Battery][HandleButtonEvents]
        lidAction=64
        powerButtonAction=16
        powerDownAction=16
        triggerLidActionWhenExternalMonitorPresent=true

        [Battery][SuspendSession]
        idleTime=900000
        suspendThenHibernate=true
        suspendType=4

        [LowBattery]
        icon=battery-low

        [LowBattery][BrightnessControl]
        value=100

        [LowBattery][DPMSControl]
        idleTime=300
        lockBeforeTurnOff=0

        [LowBattery][HandleButtonEvents]
        lidAction=1
        powerButtonAction=16
        powerDownAction=16
        triggerLidActionWhenExternalMonitorPresent=false

        [LowBattery][SuspendSession]
        idleTime=1200000
        suspendThenHibernate=false
        suspendType=1
      '';
    };
  };
}