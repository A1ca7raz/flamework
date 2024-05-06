{ lib, ... }:
with lib; {
  utils.kconfig.files.powerdevilrc.items = [
    (mkItem "BatteryManagement" "BatteryCriticalAction" "1")
  ];

  utils.kconfig.files.powermanagementprofilesrc.items = [
    (mkItem "AC" "icon" "battery-charging")
    (mkItem ["AC" "BrightnessControl"] "value" "100")
    (mkItem ["AC" "HandleButtonEvents"] "lidAction" "64")
    (mkItem ["AC" "HandleButtonEvents"] "powerButtonAction" "16")
    (mkItem ["AC" "HandleButtonEvents"] "powerDownAction" "16")
    (mkItem ["AC" "HandleButtonEvents"] "triggerLidActionWhenExternalMonitorPresent" "false")

    (mkItem "Battery" "icon" "battery-060")
    (mkItem ["Battery" "BrightnessControl"] "value" "100")
    (mkItem ["Battery" "DPMSControl"] "idleTime" "600")
    (mkItem ["Battery" "HandleButtonEvents"] "lidAction" "64")
    (mkItem ["Battery" "HandleButtonEvents"] "powerButtonAction" "16")
    (mkItem ["Battery" "HandleButtonEvents"] "powerDownAction" "16")
    (mkItem ["Battery" "HandleButtonEvents"] "triggerLidActionWhenExternalMonitorPresent" "true")
    (mkItem ["Battery" "SuspendSession"] "idleTime" "900000")
    (mkItem ["Battery" "SuspendSession"] "suspendThenHibernate" "true")
    (mkItem ["Battery" "SuspendSession"] "suspendType" "4")

    (mkItem "LowBattery" "icon" "battery-low")
    (mkItem ["LowBattery" "BrightnessControl"] "value" "100")
    (mkItem ["LowBattery" "DPMSControl"] "idleTime" "300")
    (mkItem ["LowBattery" "DPMSControl"] "lockBeforeTurnOff" "0")
    (mkItem ["LowBattery" "HandleButtonEvents"] "lidAction" "1")
    (mkItem ["LowBattery" "HandleButtonEvents"] "powerButtonAction" "16")
    (mkItem ["LowBattery" "HandleButtonEvents"] "powerDownAction" "16")
    (mkItem ["LowBattery" "HandleButtonEvents"] "triggerLidActionWhenExternalMonitorPresent" "false")
    (mkItem ["LowBattery" "SuspendSession"] "idleTime" "1200000")
    (mkItem ["LowBattery" "SuspendSession"] "suspendThenHibernate" "false")
    (mkItem ["LowBattery" "SuspendSession"] "suspendType" "1")
  ];
}