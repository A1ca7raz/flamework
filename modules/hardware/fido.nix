{ pkgs, ... }:
{
  services.udev = {
    packages = with pkgs; [
      yubikey-personalization
      libfido2
    ];

    # for Canokeys
    extraRules = ''
      # GnuPG/pcsclite
      SUBSYSTEM!="usb", GOTO="canokeys_rules_end"
      ACTION!="add|change", GOTO="canokeys_rules_end"
      ATTRS{idVendor}=="20a0", ATTRS{idProduct}=="42d4", ENV{ID_SMARTCARD_READER}="1"
      LABEL="canokeys_rules_end"

      # FIDO2/U2F
      # note that if you find this line in 70-u2f.rules, you can ignore it
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="20a0", ATTRS{idProduct}=="42d4", TAG+="uaccess", GROUP="plugdev", MODE="0660"

      # make this usb device accessible for users, used in WebUSB
      # change the mode so unprivileged users can access it, insecure rule, though
      SUBSYSTEMS=="usb", ATTR{idVendor}=="20a0", ATTR{idProduct}=="42d4", MODE:="0666"
    '';
  };
}