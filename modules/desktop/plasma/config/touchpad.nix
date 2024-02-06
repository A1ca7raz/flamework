{ ... }:
{
  # NOTE: kwriteconfig5 cannot proceed "-0.1"
  utils.kconfig.files.touchpadxlibinputrc.extraScript = ''
    echo > $out << EOF
    [MSFT0004:00 06CB:CE2D Touchpad]
    clickMethodAreas=false
    clickMethodClickfinger=true
    disableWhileTyping=false
    lmrTapButtonMap=false
    lrmTapButtonMap=true
    middleEmulation=false
    pointerAcceleration=-0.1
    pointerAccelerationProfileAdaptive=true
    pointerAccelerationProfileFlat=false
    tapToClick=true
    EOF
  '';
}
