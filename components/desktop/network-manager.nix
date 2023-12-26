{ pkgs, ... }:
{
  environment.persistence."/nix/persist".directories = [
    "/etc/NetworkManager/system-connections"
  ];

  environment.systemPackages = with pkgs; [
    iw
    iwd
  ];

  users.users.nomad.extraGroups = [ "networkmanager" ];
  users.extraGroups.networkmanager.members = ["root"];

  networking.networkmanager = {
    enable = true;
    # dns = "dnsmasq";

    # NOTE: Use wpa_supplicant for WiFi-Direct support
    wifi.backend = "iwd";
  };
}