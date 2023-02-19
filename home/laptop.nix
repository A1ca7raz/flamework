# For Profile 'Laptop'
{ ... }:
{
  imports = [ ./desktop.nix ];

  # TouchPad Config
  xdg.configFile.touchpadxlibinputrc = {
    target = "touchpadxlibinputrc";
    text = ''
      [MSFT0004:00 06CB:CE2D Touchpad]
      clickMethodAreas=false
      clickMethodClickfinger=true
      disableWhileTyping=false
      lmrTapButtonMap=false
      lrmTapButtonMap=true
      middleEmulation=false
      pointerAcceleration=0
      pointerAccelerationProfileAdaptive=true
      pointerAccelerationProfileFlat=false
      tapToClick=true
    '';
  };
}